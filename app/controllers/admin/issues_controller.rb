class Admin::IssuesController < Admin::BaseController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = Issue.order(position: :asc)
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      redirect_to admin_issue_path(@issue), notice: "Issue created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      redirect_to admin_issue_path(@issue), notice: "Issue updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @issue.destroy
    redirect_to admin_issues_path, notice: "Issue deleted."
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.expect(issue: [:title, :description, :icon, :status, :position, :featured])
  end
end
