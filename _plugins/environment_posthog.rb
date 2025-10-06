# frozen_string_literal: true

module Jekyll
  class EnvironmentPosthogGenerator < Generator
    priority :highest

    def generate(site)
      # PostHog should only run in production
      jekyll_env = ENV["JEKYLL_ENV"] || "development"

      # Ensure the jekyll_analytics config exists
      site.config["jekyll_analytics"] ||= {}
      site.config["jekyll_analytics"]["PostHog"] ||= {}

      # Always set the URL (from config or default)
      unless site.config["jekyll_analytics"]["PostHog"]["url"]
        site.config["jekyll_analytics"]["PostHog"]["url"] = "https://eu.posthog.com"
      end

      if jekyll_env == "production"
        # Read PostHog API key from environment variable
        posthog_api_key = ENV.fetch("POSTHOG_API_KEY", nil)

        # Set the apikey with environment variable if present
        if posthog_api_key && !posthog_api_key.empty?
          site.config["jekyll_analytics"]["PostHog"]["apikey"] = posthog_api_key
          Jekyll.logger.info "PostHog:", "Analytics enabled (production mode)"
        else
          Jekyll.logger.warn "PostHog:", "No API key found in environment - analytics disabled"
          # Clear any existing key to ensure analytics don't run
          site.config["jekyll_analytics"]["PostHog"].delete("apikey")
        end
      else
        # Development mode - clear the API key to disable analytics
        site.config["jekyll_analytics"]["PostHog"].delete("apikey")
        Jekyll.logger.info "PostHog:", "Analytics disabled (development mode)"
      end
    end
  end
end
