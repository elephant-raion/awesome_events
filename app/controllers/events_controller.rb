class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show
  before_action :set_own_event, only: %i[edit update destroy]

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: '作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: '作成しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    redirect_to root_path, notice: '削除しました'
  end

  private

  def event_params
    params.require(:event).permit(%i[name place content start_at end_at])
  end

  def set_own_event
    @event = current_user.created_events.find(params[:id])
  end
end
