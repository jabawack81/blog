# Blog Improvements Checklist

## 🚨 Critical Security Issues (Do First)
- [ ] Update vulnerable gems: `bundle update json nokogiri`
  - JSON gem CVE-2025-27788 (update to >= 2.10.2)  
  - Nokogiri vulnerabilities (update to >= 1.18.8)
- [ ] Move PostHog API key from `_config.yml` to environment variables
  - Current key exposed in line 177 of `_config.yml`

## 🔴 High Priority Updates
- [ ] Update Chirpy theme from 7.1.1 to 7.3.1
  - Update `Gemfile`: `gem "jekyll-theme-chirpy", "7.3.1"`
- [ ] Replace placeholder content in `_tabs/about.md`
  - Currently shows: "Add Markdown syntax content to file..."
- [ ] Update Jekyll from 4.3.4 to 4.4.1
- [ ] Update html-proofer from 5.0.9 to 5.0.10

## 🟡 Medium Priority Improvements
- [ ] Improve GitHub Actions workflow (`.github/workflows/pages-deploy.yml`)
  - [ ] Update Ruby version from 3.3 to 3.4.2
  - [ ] Add dependency caching with `bundler-cache: true`
  - [ ] Add security audit step with `bundler-audit`
- [ ] Fix SEO configurations in `_config.yml`
  - [ ] Add actual Google site verification code
  - [ ] Add Google Analytics ID (currently empty)
  - [ ] Add missing plugins: jekyll-sitemap, jekyll-feed, jekyll-seo-tag
- [ ] Fix typos in `tools/deploy.sh`
  - Line 40: "envrionment" → "environment"
  - Line 88: "CANME" → "CNAME"

## 🟢 Low Priority Enhancements
- [ ] Add security headers
  - [ ] Content Security Policy (CSP)
  - [ ] HTTP Strict Transport Security (HSTS)
  - [ ] X-Frame-Options, X-Content-Type-Options
- [ ] Create missing pages
  - [ ] Privacy policy (`_pages/privacy.md`)
  - [ ] Terms of service (`_pages/terms.md`)
  - [ ] Security policy (`.well-known/security.txt`)
- [ ] Performance optimizations
  - [ ] Convert images to WebP format
  - [ ] Implement lazy loading for images
  - [ ] Consider CDN for image delivery
- [ ] Add responsive image plugin

## Commands to Run
```bash
# Security updates (do first)
bundle update json nokogiri

# Theme and dependency updates
bundle update jekyll-theme-chirpy jekyll html-proofer

# Test after updates
bundle exec jekyll build
bundle exec htmlproofer --disable-external --allow_hash_href _site
```

---
*Generated: 2025-07-31 - Review and update as needed*