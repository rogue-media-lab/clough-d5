class HomeController < ApplicationController
  skip_before_action :require_authentication, raise: false

  def index
    @featured_issues = Issue.active.where(featured: true).order(:position)
    @active_issues = Issue.active.order(:position)
  end

  def volunteer
    @volunteer_submission = VolunteerSubmission.new
    @interests = VolunteerInterest.order(:name)
  end

  def create_volunteer_submission
    @volunteer_submission = VolunteerSubmission.new(volunteer_submission_params)
    if @volunteer_submission.save
      redirect_to volunteer_path, notice: "Thank you for volunteering! We'll be in touch soon."
    else
      @interests = VolunteerInterest.order(:name)
      render :volunteer, status: :unprocessable_entity
    end
  end

  def about
  end

  def issues
    @issues = Issue.active.order(:position)
  end

  def show_issue
    @issue = Issue.active.find(params[:id])
  end

  def news
    @featured_article = NewsArticle.published.find_by(featured: true)
    @articles = NewsArticle.published.where.not(id: @featured_article&.id).order(published_date: :desc)
  end

  def events
    @next_event = Event.upcoming.first
    @remaining_upcoming = Event.upcoming.offset(1)
    @past_events = Event.past.limit(8)
  end

  def show_event
    @event = Event.find(params[:id])
  end

  private

  def volunteer_submission_params
    params.expect(volunteer_submission: [ :name, :last_name, :email, :phone, :message, :area_code, interest_ids: [] ])
  end
end
