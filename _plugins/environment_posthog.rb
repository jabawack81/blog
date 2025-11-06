# frozen_string_literal: true

module Jekyll
  class EnvironmentPosthogGenerator < Generator
    priority :highest

    def generate(site)
      # PostHog should only run in production
      jekyll_env = ENV["JEKYLL_ENV"] || "development"

      # Ensure the jekyll_analytics config exists
      site.config["jekyll_analytics"] ||= {}

      if jekyll_env == "production"
        # Read PostHog API key from environment variable
        posthog_api_key = ENV.fetch("POSTHOG_API_KEY", nil)

        # Only configure PostHog if API key is present
        if posthog_api_key && !posthog_api_key.empty?
          site.config["jekyll_analytics"]["PostHog"] = {
            "url" => "https://eu.posthog.com",
            "apikey" => posthog_api_key
          }
          Jekyll.logger.info "PostHog:", "Analytics enabled (production mode)"
        else
          Jekyll.logger.warn "PostHog:", "No API key found in environment - analytics disabled"
          # Remove PostHog from config entirely to prevent initialization
          site.config["jekyll_analytics"].delete("PostHog")
        end
      else
        # Development mode - remove PostHog to prevent initialization
        site.config["jekyll_analytics"].delete("PostHog")
        Jekyll.logger.info "PostHog:", "Analytics disabled (development mode)"
      end
    end
  end
end
