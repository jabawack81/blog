#!/bin/bash
set -e

echo "🧪 Running comprehensive tests..."

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -n "Testing $test_name... "
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC}"
        ((TESTS_FAILED++))
        echo "  Command: $test_command"
    fi
}

# 1. Bundle install
echo "📦 Installing dependencies..."
bundle install --quiet

# 2. Security audit
echo -e "\n🔒 Security audit..."
if command -v bundle-audit &> /dev/null; then
    bundle-audit check --update
else
    echo -e "${YELLOW}Warning: bundle-audit not installed${NC}"
fi

# 3. Build tests
echo -e "\n🏗️  Build tests..."
run_test "Jekyll build" "bundle exec jekyll build"
run_test "Jekyll build (production)" "JEKYLL_ENV=production bundle exec jekyll build"

# 4. HTML validation
echo -e "\n📄 HTML validation..."
run_test "HTML Proofer" "bundle exec htmlproofer --disable-external --allow_hash_href _site"

# 5. Ruby linting
echo -e "\n💎 Ruby linting..."
run_test "RuboCop" "bundle exec rubocop"

# 6. File existence tests
echo -e "\n📁 File existence tests..."
run_test "Index page exists" "test -f _site/index.html"
run_test "Feed XML exists" "test -f _site/feed.xml"
run_test "Sitemap exists" "test -f _site/sitemap.xml"
run_test "CSS compiled" "test -f _site/assets/css/jekyll-theme-chirpy.css"
run_test "JS compiled" "test -f _site/assets/js/dist/app.min.js"
run_test "404 page exists" "test -f _site/404.html"

# 7. Content tests
echo -e "\n📝 Content tests..."
run_test "Has multiple HTML files" "[ \$(find _site -name '*.html' | wc -l) -gt 5 ]"
run_test "Posts are generated" "[ \$(find _site -path '*/_posts/*' -prune -o -name '*.html' -print | grep -E '[0-9]{4}/[0-9]{2}/' | wc -l) -gt 0 ]"

# 8. Plugin functionality tests
echo -e "\n🔌 Plugin tests..."
run_test "Git last modified plugin" "grep -q 'last_modified_at' _site/index.html"

# 9. Theme integrity tests
echo -e "\n🎨 Theme tests..."
run_test "Dark mode CSS present" "grep -q 'dark-mode' _site/assets/css/jekyll-theme-chirpy.css"
run_test "Theme JS loaded" "grep -q 'chirpy' _site/assets/js/dist/app.min.js"

# 10. Performance checks
echo -e "\n⚡ Performance checks..."
CSS_SIZE=$(stat -c%s "_site/assets/css/jekyll-theme-chirpy.css" 2>/dev/null || echo 0)
if [ $CSS_SIZE -lt 500000 ]; then
    echo -e "CSS size: ${GREEN}$(($CSS_SIZE / 1024))KB${NC} ✓"
    ((TESTS_PASSED++))
else
    echo -e "CSS size: ${RED}$(($CSS_SIZE / 1024))KB${NC} (>500KB) ✗"
    ((TESTS_FAILED++))
fi

# Summary
echo -e "\n📊 Test Summary:"
echo -e "  Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "  Failed: ${RED}$TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✨ All tests passed!${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed${NC}"
    exit 1
fi