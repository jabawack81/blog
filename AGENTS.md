# AGENTS.md

Agent guidance for Internet Blacksmith Forge Jekyll blog codebase.

## Project Overview
Jekyll-based blog using Chirpy theme (v7.3.1) focused on software development content. Deployed to GitHub Pages with PostHog analytics (EU endpoint) and automated CI/CD.

## Build/Test Commands
- `bundle install` - Install Ruby dependencies
- `bundle exec jekyll serve` - Start local dev server (http://localhost:4000)
- `bundle exec jekyll build` - Build static site to _site/
- `JEKYLL_ENV=production bundle exec jekyll build` - Production build
- `bash test.sh` - Run comprehensive test suite (HTML validation, linting, builds)
- `bundle exec htmlproofer --disable-external --allow_hash_href _site` - Validate HTML
- `bundle exec rubocop` - Lint Ruby code (plugins, config files)
- `bash tools/deploy.sh --dry-run` - Build and test without deployment
- `./bin/new-post "Post Title"` - Create new blog post with frontmatter

## Architecture & Structure
- **Posts**: _posts/ with YYYY-MM-DD-title.md format; require title, date, categories, tags in frontmatter
- **Pages**: _tabs/ for static pages (About, Archives, Categories, Tags)
- **Plugins**: _plugins/ with custom Ruby plugins including git-based last modified date tracking
- **Assets**: assets/img/ for images and favicons; posts images in assets/img/posts/
- **Config**: _config.yml (main Jekyll config), Gemfile (Ruby deps), _data/ (contact/sharing config)

## Code Style
- **Ruby**: Follow RuboCop rules (.rubocop.yml); use double quotes for strings; frozen_string_literal: true
- **Jekyll**: Use YAML frontmatter for posts; date format: YYYY-MM-DD HH:MM:SS +0000 (with timezone)
- **Files**: Posts in _posts/ with YYYY-MM-DD-title.md format; use existing plugin patterns
- **Config**: Never modify git config; avoid external dependencies without checking Gemfile first
- **Content**: Conversational, beginner-friendly tone; categories: 'Development', 'New Devs'

## Testing
- Always run `bash test.sh` before major changes - validates builds, HTML, Ruby code, and content
- Never commit without testing - build must pass in both dev and production modes
- HTML Proofer validates generated site integrity and link structure