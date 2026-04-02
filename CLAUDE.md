# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Jekyll-based blog using Chirpy theme (v7.4.1) focused on software development content. Deployed to GitHub Pages with PostHog analytics and automated CI/CD.

## Build & Development Commands

```bash
bundle install                                    # Install Ruby dependencies
bundle exec jekyll serve                          # Local dev server (http://localhost:4000)
bundle exec jekyll build                          # Build to _site/
JEKYLL_ENV=production bundle exec jekyll build    # Production build (enables analytics)
./bin/new-post "Post Title"                       # Create new blog post
bash test.sh                                      # Comprehensive test suite
bash tools/deploy.sh --dry-run                    # Build and test without deployment
bundle exec rubocop                               # Lint Ruby code
bundle exec htmlproofer --disable-external --allow_hash_href _site  # Validate HTML
```

## Architecture

- **Posts**: `_posts/` with `YYYY-MM-DD-title.md` format; require title, date, categories, tags in frontmatter
- **Pages**: `_tabs/` for navigation pages (About, Archives, Categories, Tags); `_pages/` for other static pages
- **Plugins** (`_plugins/`):
  - `environment_posthog.rb` - Conditionally enables PostHog analytics in production via `POSTHOG_API_KEY` env var
  - `posts-lastmod-hook.rb` - Git-based last modified date tracking (requires full git history)
  - `image_optimizer.rb` - Auto-adds lazy loading to images
- **Assets**: `assets/img/` for images and favicons; post images in `assets/img/posts/`
- **Config**: `_config.yml` (main), `Gemfile` (deps), `_data/` (contact/sharing)

## Code Style

- **Ruby**: Follow `.rubocop.yml`; use double quotes; add `frozen_string_literal: true` pragma
- **Posts**: YAML frontmatter required; date format `YYYY-MM-DD HH:MM:SS +0000`; categories: 'Development', 'New Devs'
- **Content**: Conversational, beginner-friendly tone
- **Config**: Never modify git config; avoid adding external dependencies without checking Gemfile first

## Testing Requirements

- Run `bash test.sh` before major changes - validates builds, HTML, Ruby code, plugins, and theme integrity
- CI tests against Ruby 3.3 and 3.4.1; local development uses Ruby 3.3.1
- Production builds require full git history for last-modified tracking
