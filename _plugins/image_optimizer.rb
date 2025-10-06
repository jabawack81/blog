# frozen_string_literal: true

# This plugin adds lazy loading to images automatically
module Jekyll
  module LazyLoadImages
    def lazy_load_images(content)
      return content if content.nil?

      # Add loading="lazy" to img tags that don't already have it
      content.gsub(/<img(?![^>]*loading\s*=)([^>]*)>/i) do |_match|
        "<img#{::Regexp.last_match(1)} loading=\"lazy\">"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::LazyLoadImages)
