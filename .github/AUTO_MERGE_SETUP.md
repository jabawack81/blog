# Dependabot Auto-Merge Setup

## Repository Settings Required

To enable auto-merge for Dependabot PRs, you need to configure these GitHub repository settings:

### 1. Enable Auto-Merge
1. Go to Settings → General
2. Under "Pull Requests", enable "Allow auto-merge"

### 2. Configure Branch Protection Rules
1. Go to Settings → Branches
2. Add a rule for `main` branch with:
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
     - Required checks: `test (3.3)`, `test (3.4)`
   - ✅ Dismiss stale pull request approvals when new commits are pushed
   - ✅ Require branches to be up to date before merging

### 3. Create Labels (if they don't exist)
Run these commands to create the necessary labels:
```bash
gh label create "automerge-patch" --description "Auto-merge patch updates" --color "0e8a16"
gh label create "automerge-minor" --description "Auto-merge minor updates" --color "5319e7"
gh label create "requires-review" --description "Manual review required" --color "d93f0b"
```

## How Auto-Merge Works

### Automatically Merged:
- **Patch updates** (x.x.1 → x.x.2) for all dependencies
- **Minor updates** (x.1.x → x.2.x) for development dependencies only

### Requires Manual Review:
- **Major updates** (1.x.x → 2.x.x) for any dependency
- **Minor updates** for production dependencies (Jekyll, Chirpy theme)
- Any update that fails automated tests

### The Workflow:
1. Dependabot creates a PR
2. Our test workflow runs (`test-pr.yml`)
3. If tests pass, auto-merge workflow:
   - Approves safe updates
   - Adds appropriate labels
   - Waits for all checks to complete
   - Auto-merges if criteria are met
4. For non-safe updates, adds comment requesting manual review

## Monitoring

- Check the "Actions" tab for workflow runs
- PRs with `requires-review` label need your attention
- Auto-merged PRs will be labeled with `automerge-patch` or `automerge-minor`

## Disable Auto-Merge

To temporarily disable auto-merge, you can:
1. Disable the workflow: Settings → Actions → Workflows → "Dependabot Auto-Merge" → Disable workflow
2. Or add this to the workflow file:
   ```yaml
   if: false  # Add this to line 12 to disable
   ```