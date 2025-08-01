# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Jekyll-based blog called "Internet Blacksmith Forge" focused on software development content. It uses the Chirpy theme (v7.1.1) and is deployed to GitHub Pages.

## Commands

### Development
```bash
bundle install                    # Install Ruby dependencies
bundle exec jekyll serve          # Start local development server (http://localhost:4000)
bundle exec jekyll build          # Build the static site to _site/
```

### Testing & Linting
```bash
bundle exec htmlproofer --disable-external --allow_hash_href _site  # Validate HTML output
bundle exec rubocop                                                  # Lint Ruby code (plugins, config)
```

### Deployment
```bash
bash tools/deploy.sh              # Build, test, and deploy to GitHub Pages
bash tools/deploy.sh --dry-run    # Build and test only (no deployment)
```

### Content Creation
```bash
bundle exec jekyll compose "Post Title" --post  # Create new blog post with proper frontmatter
```

## Architecture

### Jekyll Structure
- `_posts/`: Blog posts in Markdown with YAML frontmatter (format: YYYY-MM-DD-title.md)
- `_tabs/`: Static pages (About, Archives, Categories, Tags)
- `_data/`: Configuration for contact options and social sharing
- `_plugins/`: Custom Jekyll plugins (includes git-based last modified date tracking)
- `_site/`: Generated static site output (do not edit directly)
- `assets/`: Images, favicons, and site logo

### Key Configuration
- `_config.yml`: Main Jekyll configuration (site metadata, theme settings, analytics)
- `Gemfile`: Ruby dependencies
- `.github/workflows/pages-deploy.yml`: GitHub Actions deployment pipeline

### Technical Details
- **Theme**: jekyll-theme-chirpy v7.1.1
- **Ruby Version**: 3.3 (used in CI)
- **Analytics**: PostHog (EU endpoint)
- **Deployment**: Automated via GitHub Actions to `gh-pages` branch
- **Domain**: internetblacksmith.dev (configured in CNAME)

### Content Guidelines
- Posts require frontmatter with: title, date, categories, tags
- Categories in use: 'Development', 'New Devs'
- Image assets go in `assets/img/posts/`
- Git commit timestamps are used for "last modified" dates via custom plugin
- Date format in frontmatter: `YYYY-MM-DD HH:MM:SS +0000` (use timezone offset)
- Posts use conversational, beginner-friendly tone

### Development Notes
- PostHog analytics configured with EU endpoint
- Theme mode defaults to dark
- Deployment only works in GitHub Actions environment (safety check in deploy.sh)
- RuboCop configured for Ruby linting (.rubocop.yml present)