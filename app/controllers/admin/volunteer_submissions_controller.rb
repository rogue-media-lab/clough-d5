class Admin::VolunteerSubmissionsController < Admin::BaseController
  before_action :set_submission, only: [ :show, :edit, :update, :destroy ]

  def index
    @submissions = VolunteerSubmission.includes(:interests).order(created_at: :desc)

    # Filter by status
    if params[:status].present?
      @submissions = @submissions.where(submission_status: params[:status])
    end

    # Filter by interest
    if params[:interest_id].present?
      @submissions = @submissions.joins(:volunteer_submission_interests)
        .where(volunteer_submission_interests: { volunteer_interest_id: params[:interest_id] })
    end

    # Filter by date range
    if params[:from].present?
      @submissions = @submissions.where("created_at >= ?", Date.parse(params[:from]).beginning_of_day)
    end
    if params[:to].present?
      @submissions = @submissions.where("created_at <= ?", Date.parse(params[:to]).end_of_day)
    end

    # Filter by welcome email status
    if params[:welcome] == "sent"
      @submissions = @submissions.where.not(welcome_email_sent_at: nil)
    elsif params[:welcome] == "not_sent"
      @submissions = @submissions.where(welcome_email_sent_at: nil)
    end

    @interests = VolunteerInterest.order(:name)
    @current_filters = params.slice(:status, :interest_id, :from, :to, :welcome)
  end

  def show
  end

  def edit
  end

  def update
    if @submission.update(submission_params)
      redirect_to admin_volunteer_submission_path(@submission), notice: "Submission updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @submission.destroy
    redirect_to admin_volunteer_submissions_path, notice: "Submission deleted."
  end

  def mark_welcome_sent
    @submission = VolunteerSubmission.find(params[:id])
    @submission.update!(welcome_email_sent_at: Time.current)
    redirect_to admin_volunteer_submission_path(@submission), notice: "Welcome email marked as sent."
  end

  private

  def set_submission
    @submission = VolunteerSubmission.find(params[:id])
  end

  def submission_params
    params.expect(volunteer_submission: [ :name, :email, :phone, :message, :area_code, :submission_status, :welcome_email_sent_at, interest_ids: [] ])
  end
end
