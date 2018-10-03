class Ahoy::Store < Ahoy::DatabaseStore
  def visit_model
    Visit
  end
  Ahoy.api = true
  Ahoy.server_side_visits = true
  Ahoy.visit_duration = 1.minutes
  Ahoy.geocode = :async
  Ahoy.job_queue = :analytics
  Ahoy.user_agent_parser = :device_detector
end
