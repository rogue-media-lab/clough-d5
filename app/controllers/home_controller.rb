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

  def events
    @featured_event = Event.upcoming.order(:date).first
    @upcoming_events = Event.upcoming.order(:date).group_by { |e| e.date.beginning_of_month }
    @past_events = Event.past.order(date: :desc)
  end

  private

  def volunteer_submission_params
    params.expect(volunteer_submission: [:name, :last_name, :email, :phone, :message, :area_code, interest_ids: []])
  end
end