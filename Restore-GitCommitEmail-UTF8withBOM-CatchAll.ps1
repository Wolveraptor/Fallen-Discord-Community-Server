# Restore-GitCommitEmail-UTF8withBOM-CatchAll.ps1
# Rewrites ALL commits whose email does not match the noreply address.
# This script was written and developed with the assistance of Proton Lumo.

param(
    [string]$NewEmail = "ssimon@noreply.forgejo.cybersanctuary.xyz"
)

Write-Host "🔄 Scanning repository for emails that need updating..." -ForegroundColor Cyan
Write-Host "   Target email: $NewEmail"
Write-Host ""

# --- CAPTURE REMOTE INFO (before any rewriting) ---
$HasRemote   = $false
$RemoteName  = ""
$RemoteUrl   = ""

if (git remote) {
    $Remotes = @(git remote)
    if ($Remotes.Count -gt 0) {
        $HasRemote   = $true
        $RemoteName  = if ($Remotes -contains "origin") { "origin" } else { $Remotes[0] }
        $RemoteUrl   = (git remote get-url $RemoteName).Trim()
        Write-Host "🔗 Remote detected: $RemoteName -> $RemoteUrl" -ForegroundColor Cyan
    }
}

if (-not $HasRemote) {
    Write-Host "ℹ️  No git remote configured for this repository." -ForegroundColor DarkYellow
}
Write-Host ""

# --- AUDIT: find every distinct author AND committer email in history (scoped to branches/tags) ---
$AllEmails = @()
$AllEmails += (git log --branches --tags --format="%ae" | Where-Object { $_ })
$AllEmails += (git log --branches --tags --format="%ce" | Where-Object { $_ })

$DistinctEmails = @($AllEmails | Sort-Object -Unique)

if ($DistinctEmails.Count -eq 0) {
    Write-Host "❌ No commits found in this repository." -ForegroundColor Red
    exit 1
}

$MatchCount  = @($AllEmails | Where-Object { $_ -eq $NewEmail }).Count
$ChangeCount = @($AllEmails | Where-Object { $_ -ne $NewEmail }).Count

Write-Host "📧 Distinct emails found in history:" -ForegroundColor Cyan
foreach ($Email in $DistinctEmails) {
    if ($Email -eq $NewEmail) {
        Write-Host "   ✓ $Email (already correct)"
    } else {
        Write-Host "   ✗ $Email (will be rewritten)"
    }
}
Write-Host ""
Write-Host "Summary: $MatchCount email fields already correct, $ChangeCount will be changed." -ForegroundColor Cyan

if ($ChangeCount -eq 0) {
    Write-Host "✅ Every commit already uses '$NewEmail'. Nothing to do." -ForegroundColor Green
    exit 0
}

Write-Host "⚠️  This will rewrite history for ALL commits listed above." -ForegroundColor Yellow
Write-Host "   (This includes commits by other people, if any of their emails differ.)" -ForegroundColor Yellow
$Confirm = Read-Host "Are you sure you want to continue? (yes/no)"

if ($Confirm -ne "yes") {
    Write-Host "Aborted." -ForegroundColor Red
    exit 1
}

# --- EXECUTION ---
$FilterRepoAvailable = Get-Command git-filter-repo -ErrorAction SilentlyContinue

if ($FilterRepoAvailable) {
    Write-Host "🚀 Using 'git-filter-repo' (recommended)..." -ForegroundColor Green

    # Keep matching emails as-is (case-insensitive); rewrite everything else.
    $Callback = "return email if email.lower() == b'$NewEmail'.lower() else b'$NewEmail'"

    git filter-repo --email-callback $Callback --force

    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ ERROR: git-filter-repo failed with exit code $LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }

    Write-Host "✅ History rewritten with 'git-filter-repo'." -ForegroundColor Green
}
else {
    Write-Host "⚠️  'git-filter-repo' not found. Falling back to 'git filter-branch'..." -ForegroundColor Yellow

    # Squelch the filter-branch warning by setting env var
    $env:FILTER_BRANCH_SQUELCH_WARNING = "1"

    $EnvFilter = @"
        if [ "`$GIT_AUTHOR_EMAIL" != "$NewEmail" ] ; then
            export GIT_AUTHOR_EMAIL="$NewEmail"
        fi
        if [ "`$GIT_COMMITTER_EMAIL" != "$NewEmail" ] ; then
            export GIT_COMMITTER_EMAIL="$NewEmail"
        fi
"@

    git filter-branch --env-filter $EnvFilter --tag-name-filter cat -- --all

    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ ERROR: git filter-branch failed with exit code $LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }

    Write-Host "✅ History rewritten with 'git filter-branch'." -ForegroundColor Green
}

# --- CLEANUP BACKUP REFS (CRITICAL FIX) ---
Write-Host "🗑️  Removing filter-branch backup refs..." -ForegroundColor Cyan
$BackupRefs = @(git for-each-ref --format="%(refname)" refs/original/)
if ($BackupRefs) {
    foreach ($Ref in $BackupRefs) {
        git update-ref -d $Ref
    }
    Write-Host "   Deleted $($BackupRefs.Count) backup ref(s)." -ForegroundColor Cyan
} else {
    Write-Host "   No backup refs to clean up." -ForegroundColor Cyan
}

# Also prune stale remote-tracking refs
git remote prune origin 2>$null

# Expire reflog and run garbage collection
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# --- FINAL VERIFICATION AUDIT ---
Write-Host ""
Write-Host "🔍 Post-rewrite verification..." -ForegroundColor Cyan
$PostRewriteEmails = @()
$PostRewriteEmails += (git log --branches --tags --format="%ae" | Where-Object { $_ })
$PostRewriteEmails += (git log --branches --tags --format="%ce" | Where-Object { $_ })
$PostDistinctEmails = @($PostRewriteEmails | Sort-Object -Unique)

Write-Host "📧 Emails remaining after rewrite:" -ForegroundColor Cyan
foreach ($Email in $PostDistinctEmails) {
    if ($Email -eq $NewEmail) {
        Write-Host "   ✓ $Email"
    } else {
        Write-Host "   ✗ $Email (STILL PRESENT - manual intervention required)"
    }
}
Write-Host ""

# --- BUILD PUSH INSTRUCTIONS (using the remote captured at startup) ---
Write-Host "✨ Done! History rewritten." -ForegroundColor Green

if ($HasRemote) {
    $PushInstructions = @"
   1. Re-add the remote ($RemoteName):
      git remote add $RemoteName $RemoteUrl

   2. Force push all branches:
      git push --force-with-lease --all $RemoteName

   3. Force push tags too, if you have any:
      git push --force-with-lease --tags $RemoteName
"@
}
else {
    $PushInstructions = @"
   No remote was configured before the rewrite, so there is nothing to re-add.
   Add one when ready, e.g.:
      git remote add origin https://forgejo.cybersanctuary.xyz/ssimon/REPO.git

   Then push:
      git push --force-with-lease --all origin
"@
}

Write-Host $PushInstructions -ForegroundColor White