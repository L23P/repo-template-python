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

Write-Host "Applying branch protection to $owner/$repo @$Branch ..."

# Build protection JSON
$protection = @{ 
  required_status_checks = @{ strict = $true; contexts = @() }; # Add specific contexts in UI if desired
  enforce_admins = $false;
  required_pull_request_reviews = @{ 
    dismiss_stale_reviews = $true; 
    require_code_owner_reviews = [bool]$RequireCodeOwners;
    required_approving_review_count = $RequiredApprovals 
  };
  restrictions = $null; # No user/team push restrictions
  required_linear_history = $true;
  allow_force_pushes = $false;
  allow_deletions = $false;
  required_conversation_resolution = $true;
  block_creations = $false;
}

$json = $protection | ConvertTo-Json -Depth 8

# Apply classic branch protection
$json | gh api -X PUT "repos/$owner/$repo/branches/$Branch/protection" `
  -H "Accept: application/vnd.github+json" `
  --input - | Out-Null

if ($LASTEXITCODE -ne 0) { Fail "Failed to apply branch protection" }

# Enable signed commits (commit signature protection)
$null = gh api -X POST "repos/$owner/$repo/branches/$Branch/protection/required_signatures" `
  -H "Accept: application/vnd.github+json" 2>$null
if ($LASTEXITCODE -eq 0) {
  Write-Host "Enabled commit signature protection"
} else {
  Write-Warning "Could not enable commit signature protection (requires admin + appropriate plan). Skipping."
}

Write-Host "Branch protection applied. Consider adding required status checks in Settings > Branches after one CI run to capture exact check names."