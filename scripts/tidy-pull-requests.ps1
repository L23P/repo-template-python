param(
  [string]$State = "open",
  [switch]$CloseAll,
  [string]$Comment = "Closing as the baseline work is complete; feel free to reopen with new scope."
)

function Fail($msg) {
  Write-Error $msg
  exit 1
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { Fail "GitHub CLI 'gh' is required: https://cli.github.com/" }
$null = gh auth status 2>$null
if ($LASTEXITCODE -ne 0) { Fail "Run 'gh auth login' first" }

# Get repo
$remote = git remote get-url origin 2>$null
if (-not $remote) { Fail "Couldn't determine 'origin' remote" }
if ($remote -match 'github.com[:/](?<owner>[^/]+)/(?<repo>[^/.]+)') {
  $owner = $Matches['owner']
  $repo = $Matches['repo']
} else {
  Fail "Failed to parse owner/repo from remote URL: $remote"
}

Write-Host "Fetching PRs for $owner/$repo (state=$State) ..."
$prsJson = gh pr list --repo "$owner/$repo" --state $State --json number,title,headRefName,author | ConvertFrom-Json
if (-not $prsJson -or $prsJson.Count -eq 0) { Write-Host "No PRs found"; exit 0 }

foreach ($pr in $prsJson) {
  $n = $pr.number
  Write-Host "PR #$n - $($pr.title)"
  if ($CloseAll) {
    if ($Comment) { gh pr comment $n --repo "$owner/$repo" --body "$Comment" | Out-Null }
    gh pr close $n --repo "$owner/$repo" --delete-branch | Out-Null
    Write-Host "Closed PR #$n and deleted branch (if permitted)"
  }
}
