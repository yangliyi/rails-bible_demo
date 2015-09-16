class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  #GET /events/index
  #GET /events
  def index
    @events = Event.page(params[:page]).per(5)
  end

  #GET /events/show/:id
  def show
    @page_title = @event.name
  end


  #GET /events/new
  def new
    @event = Event.new
  end


  #POST /events/create
  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to :action => :index # HTTP code: 303 重發 GET
    else
      render :action => :new #new.html.erb
    end

  end

  # GET /events/edit/:id
  def edit

  end

  #POST /events/update/:id
  def update

    if @event.update(event_params)
      flash[:notice] = "event was successfully updated"
      redirect_to :action => :show, :id => @event
    else
      # redirect_to :action => :edit, :id => @event
      render :action => :edit # edit.html.erb
    end
  end

  #GET /events/destroy/:id
  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    redirect_to :action => :index # HTTP code: 303 重發 GET

  end

  def set_event
    @event = Event.find(params[:id])
  end

  private

  def event_params
  params.require(:event).permit(:name, :description)
  end

end
