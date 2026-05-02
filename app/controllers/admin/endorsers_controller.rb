class Admin::EndorsersController < Admin::BaseController
  before_action :set_endorser, only: [ :show, :edit, :update, :destroy ]

  def index
    @endorsers = Endorser.ordered
  end

  def show
  end

  def new
    @endorser = Endorser.new
  end

  def create
    @endorser = Endorser.new(endorser_params)
    if @endorser.save
      redirect_to admin_endorser_path(@endorser), notice: "Endorser added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @endorser.update(endorser_params)
      redirect_to admin_endorser_path(@endorser), notice: "Endorser updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @endorser.destroy
    redirect_to admin_endorsers_path, notice: "Endorser removed."
  end

  private

  def set_endorser
    @endorser = Endorser.find(params[:id])
  end

  def endorser_params
    params.expect(endorser: [ :name, :title, :quote, :category, :photo_url, :sort_order, :active ])
  end
end
