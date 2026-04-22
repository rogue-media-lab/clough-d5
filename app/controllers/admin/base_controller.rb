class Admin::BaseController < ApplicationController
  before_action :require_admin

  layout "admin"

  private

  def require_admin
    redirect_to root_path, alert: "Not authorized." unless Current.session&.user&.admin?
  end

  def current_user
    Current.session&.user
  end
end
