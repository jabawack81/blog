# SEO Setup Guide for Internet Blacksmith Blog

## Current SEO Configuration Status

### ✅ Already Configured
- **Jekyll SEO plugins**: `jekyll-seo-tag` and `jekyll-sitemap` are active
- **Sitemap**: Auto-generated at `/sitemap.xml`
- **Robots.txt**: Auto-generated
- **Twitter Cards**: Configured for @jabawack81
- **Meta tags**: Automatically added by jekyll-seo-tag
- **Analytics**: PostHog configured (instead of Google Analytics)

### 🔄 Pending Setup
- Google Search Console verification
- Domain/subdomain configuration

## Domain Configuration

### Current Setup Issue
- **CNAME file**: `internetblacksmith.dev`
- **_config.yml**: `url: "https://blog.internetblacksmith.dev"`
- These should match!

### Recommended Structure
```
internetblacksmith.dev         → Main personal/portfolio site
blog.internetblacksmith.dev    → This Jekyll blog
```

### To Fix Domain Configuration

#### Option 1: Use Subdomain (Recommended)
1. Update CNAME file:
   ```
   blog.internetblacksmith.dev
   ```

2. Keep _config.yml as is:
   ```yaml
   url: "https://blog.internetblacksmith.dev"
   ```

3. Configure DNS:
   - Add CNAME record: `blog` → `jabawack81.github.io`

#### Option 2: Use Main Domain
1. Keep CNAME file:
   ```
   internetblacksmith.dev
   ```

2. Update _config.yml:
   ```yaml
   url: "https://internetblacksmith.dev"
   ```

## Google Search Console Setup

### When to Set Up
After your domain is properly configured and GitHub Pages is serving your site.

### Steps to Configure

1. **Go to Google Search Console**
   - Visit: https://search.google.com/search-console

2. **Add Property**
   - Choose "URL prefix" (not Domain)
   - Enter: `https://blog.internetblacksmith.dev` (or your chosen URL)

3. **Verify Ownership**
   - Select "HTML tag" method
   - Copy the content value from the meta tag they provide
   - It looks like: `<meta name="google-site-verification" content="ABC123...XYZ" />`
   - You only need the `ABC123...XYZ` part

4. **Add to Jekyll**
   ```yaml
   # In _config.yml
   google_site_verification: ABC123...XYZ  # Your actual verification code
   ```

5. **Deploy and Verify**
   - Commit and push the change
   - Wait for GitHub Pages to deploy
   - Click "Verify" in Search Console

6. **Submit Sitemap**
   - In Search Console, go to Sitemaps
   - Add: `sitemap.xml`
   - Your full sitemap URL: `https://blog.internetblacksmith.dev/sitemap.xml`

### Why URL Prefix (Not Domain Property)
- **Domain property**: Requires DNS verification, covers all subdomains
- **URL prefix**: Easier HTML verification, specific to your blog subdomain

## Benefits of Search Console

Even though you use PostHog for analytics, Search Console provides:
- **Search Performance**: What queries bring people to your site
- **Index Coverage**: Which pages Google has indexed
- **Mobile Usability**: Mobile-friendly issues
- **Core Web Vitals**: Page speed and user experience metrics
- **Crawl Errors**: Find and fix 404s or other issues

## Verification Checklist

Before setting up Search Console:
- [ ] Domain is accessible (blog.internetblacksmith.dev or internetblacksmith.dev)
- [ ] Site loads with HTTPS
- [ ] CNAME and _config.yml URL match
- [ ] GitHub Pages shows "Your site is published"

## Current Files to Update

1. **CNAME** - Should match your chosen domain
2. **_config.yml** - `url:` should match CNAME with https://
3. **_config.yml** - Add `google_site_verification:` when you have the code

## No Google Analytics Needed

You're using PostHog for analytics, which is:
- More privacy-friendly
- More feature-rich
- Already configured in production

Google Analytics is not needed and has been removed from the configuration.

---
*Last updated: 2025-08-03*