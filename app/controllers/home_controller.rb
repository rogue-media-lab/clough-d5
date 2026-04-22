class HomeController < ApplicationController
  skip_before_action :require_authentication, raise: false

  def index
    @featured_issues = Issue.active.where(featured: true).order(:position)
    @active_issues = Issue.active.order(:position)
  end

  def volunteer
  end

  def about
  end

  def events
  end
end
