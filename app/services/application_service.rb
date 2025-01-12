class ApplicationService
  def self.call(*args)
    new(*args).call
  rescue StandardError => e
    Rails.logger.error("Service call failed: #{e.message}")
    raise e
  end
end