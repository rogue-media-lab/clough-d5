class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @upcoming = Event.upcoming
    @past = Event.past.limit(20)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event), notice: "Event created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Event updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: "Event deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.expect(event: [ :title, :description, :date, :location, :image, :status, :latitude, :longitude ])
  end
end
