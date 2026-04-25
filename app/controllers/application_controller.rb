class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def after_authentication_url
    session.delete(:return_to_after_authenticating) || (Current.user&.admin? ? admin_root_url : root_url)
  end
end
