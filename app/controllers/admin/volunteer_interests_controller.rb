class Admin::VolunteerInterestsController < Admin::BaseController
  before_action :set_interest, only: [:edit, :update, :destroy]

  def index
    @interests = VolunteerInterest.order(:name)
  end

  def new
    @interest = VolunteerInterest.new
  end

  def create
    @interest = VolunteerInterest.new(interest_params)
    if @interest.save
      redirect_to admin_volunteer_interests_path, notice: "Interest created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @interest.update(interest_params)
      redirect_to admin_volunteer_interests_path, notice: "Interest updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @interest.destroy
    redirect_to admin_volunteer_interests_path, notice: "Interest deleted."
  end

  private

  def set_interest
    @interest = VolunteerInterest.find(params[:id])
  end

  def interest_params
    params.expect(volunteer_interest: [:name])
  end
end