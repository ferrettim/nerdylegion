namespace :migrateahoy do
  desc "Migrate Ahoy to Device Detector"
  task :migrate => :environment do
    Ahoy::Visit.find_each do |visit|
      client = DeviceDetector.new(visit.user_agent)
      device_type =
        case client.device_type
        when "smartphone"
          "Mobile"
        when "tv"
          "TV"
        else
          client.device_type.try(:titleize)
        end

      visit.browser = client.name
      visit.os = client.os_name
      visit.device_type = device_type
      visit.save(validate: false) if visit.changed?
    end
  end
end
