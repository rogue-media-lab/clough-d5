class Admin::PrioritiesController < Admin::BaseController
  before_action :set_priority, only: [ :show, :edit, :update, :destroy ]

  def index
    @priorities = Priority.ordered
  end

  def show
  end

  def new
    @priority = Priority.new
  end

  def create
    @priority = Priority.new(priority_params)
    if @priority.save
      redirect_to admin_priority_path(@priority), notice: "Priority created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @priority.update(priority_params)
      redirect_to admin_priority_path(@priority), notice: "Priority updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @priority.destroy
    redirect_to admin_priorities_path, notice: "Priority removed."
  end

  private

  def set_priority
    @priority = Priority.find(params[:id])
  end

  def priority_params
    params.expect(priority: [ :title, :description, :icon, :show_icon, :position, :active, :linked_issue_id ])
  end
end
