param(
  [string]$Branch = "main",
  [int]$RequiredApprovals = 1,
  [switch]$RequireCodeOwners
)

function Fail($msg) {
  Write-Error $msg
  exit 1
}

# Ensure prerequisites
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Fail "git is required on PATH" }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { Fail "GitHub CLI 'gh' is required: https://cli.github.com/" }

# Ensure gh is authenticated
$null = gh auth status 2>$null
if ($LASTEXITCODE -ne 0) { Fail "Run 'gh auth login' first" }

# Derive owner/repo from git remote
$remote = git remote get-url origin 2>$null
if (-not $remote) { Fail "Couldn't determine 'origin' remote" }

$owner = $null
$repo = $null
if ($remote -match 'github.com[:/](?<owner>[^/]+)/(?<repo>[^/.]+)') {
  $owner = $Matches['owner']
  $repo = $Matches['repo']
}
if (-not $owner -or -not $repo) { Fail "Failed to parse owner/repo from remote URL: $remote" }

Write-Host "Applying minimal branch protection to $owner/$repo @$Branch ..."

# Build protection JSON (minimal): require PR reviews and conversation resolution
$protection = @{ 
  required_status_checks = $null; # Minimal: do not preconfigure checks; set in UI after CI establishes names
  enforce_admins = $false;
  required_pull_request_reviews = @{ 
    dismiss_stale_reviews = $true; 
    require_code_owner_reviews = [bool]$RequireCodeOwners;
    required_approving_review_count = $RequiredApprovals 
  };
  restrictions = $null; # No user/team push restrictions
  allow_force_pushes = $false;
  allow_deletions = $false;
  required_conversation_resolution = $true;
}

$json = $protection | ConvertTo-Json -Depth 8

# Apply classic branch protection
$json | gh api -X PUT "repos/$owner/$repo/branches/$Branch/protection" `
  -H "Accept: application/vnd.github+json" `
  --input - | Out-Null

if ($LASTEXITCODE -ne 0) { Fail "Failed to apply branch protection" }

Write-Host "Minimal branch protection applied. Next: add required status checks in Settings > Branches after a CI run to capture exact check names."