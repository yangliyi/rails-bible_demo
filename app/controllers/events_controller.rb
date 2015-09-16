class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  #GET /events/index
  #GET /events
  def index
    @events = Event.page(params[:page]).per(5)

      respond_to do |format|
      format.html # index.html.erb
      format.xml {
        render :xml => @events.to_xml
      }
      format.json {
        render :json => @events.to_json
      }
      format.atom {
        @feed_title = "My event list"
      } # index.atom.builder
      end
  end

  #GET /events/:id
  def show
    @page_title = @event.name
    respond_to do |format|
    format.html { @page_title = @event.name } # show.html.erb
    format.xml # show.xml.builder
    format.json {
      render :json => { id: @event.id, name: @event.name }.to_json
    }
    end
  end


  #GET /events/new
  def new
    @event = Event.new
  end


  #POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to events_path # HTTP code: 303 重發 GET
    else
      render :action => :new #new.html.erb
    end

  end

  #GET /events/:id/edit
  def edit

  end

  #PATCH /events/:id
  def update

    if @event.update(event_params)
      flash[:notice] = "event was successfully updated"
      redirect_to event_path(@event)
    else
      # redirect_to :action => :edit, :id => @event
      render :action => :edit # edit.html.erb
    end
  end

  #DELETE /events/:id
  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    redirect_to events_path # HTTP code: 303 重發 GET

  end

  def set_event
    @event = Event.find(params[:id])
  end

  private

  def event_params
  params.require(:event).permit(:name, :description)
  end

end
