class Admin::VolunteerSubmissionsController < Admin::BaseController
  before_action :set_submission, only: [ :show, :edit, :update, :destroy ]

  def index
    @submissions = VolunteerSubmission.order(created_at: :desc)
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

  private

  def set_submission
    @submission = VolunteerSubmission.find(params[:id])
  end

  def submission_params
    params.expect(volunteer_submission: [ :name, :email, :phone, :message, :area_code, :submission_status, interest_ids: [] ])
  end
end
