# Performance optimizations for the application

# Enable query log tags to identify slow queries
Rails.application.configure do
  # Log query plans for slow queries (>= 500ms)
  config.active_record.query_log_tags_enabled = true
  config.active_record.query_log_tags = [ :application, :controller, :action ]
  
  # Warn on queries that return more than 1000 records
  config.active_record.warn_on_records_fetched_greater_than = 1000
  
  # Enable automatic explain for slow queries in development
  if Rails.env.development?
    config.active_record.auto_explain_threshold_in_seconds = 0.5
  end
end

# Configure pg_search settings for better performance
if defined?(PgSearch)
  PgSearch.multisearch_options = {
    using: {
      tsearch: { prefix: true, any_word: true },
      trigram: { threshold: 0.3 }
    }
  }
end