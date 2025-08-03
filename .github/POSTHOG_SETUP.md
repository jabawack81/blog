# PostHog Environment Variable Setup

## Overview
The PostHog API key has been moved from `_config.yml` to environment variables for security.
PostHog analytics are **only enabled in production** to avoid polluting analytics with development data.

## GitHub Actions Setup (Required)

1. Go to your repository on GitHub
2. Navigate to: Settings → Environments → `github-pages`
3. Add a new secret:
   - Name: `POSTHOG_API_KEY`
   - Value: `phc_GFYckmtwGKcwfsxopEVWhbrL1saWaWFWchCpkFwCRyK`

## Local Development

**Analytics are disabled by default in development mode.** You'll see:
```
PostHog: Analytics disabled (development mode)
```

This is intentional - we don't want to track local development activity.

### Testing Analytics Locally (Not Recommended)
If you need to test analytics locally:
```bash
JEKYLL_ENV=production POSTHOG_API_KEY="your-key" bundle exec jekyll build
```

## How It Works

1. The custom plugin `_plugins/environment_posthog.rb` runs before Jekyll builds
2. It checks if `JEKYLL_ENV=production`
3. In production: reads `POSTHOG_API_KEY` and enables analytics
4. In development: disables analytics completely

## Production vs Development

| Environment | JEKYLL_ENV | Analytics | Message |
|------------|------------|-----------|---------|
| Local dev | development | ❌ Disabled | "Analytics disabled (development mode)" |
| GitHub Actions | production | ✅ Enabled | "Analytics enabled (production mode)" |
| Local test | production | ✅ Enabled* | "Analytics enabled (production mode)" |

*Only if POSTHOG_API_KEY is set

## Troubleshooting

- Local development shows "Analytics disabled" - This is correct!
- Production shows "No API key found" - Check GitHub secret is set
- Production shows "Analytics enabled" - Everything is working correctly