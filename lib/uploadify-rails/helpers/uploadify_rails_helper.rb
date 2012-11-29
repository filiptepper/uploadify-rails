module UploadifyRailsHelper
  def uploadify_rails_options
    config = Uploadify::Rails.configuration
    if defined?(FlashCookieSession)
      config.uploadify_options(request_forgery_protection_token, cookies, form_authenticity_token)
    else
      config.uploadify_options
    end
  end
end
