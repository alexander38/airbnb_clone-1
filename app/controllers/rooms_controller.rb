class RoomsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "Thanks for adding a new Room!"
      redirect_to root_url
    else
      render new_room_path
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = 'Room Updated'
      redirect_to room_path(@room)
    else
      flash[:notice] = 'Failed to Update'
      redirect_to :back
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "Room Deleted"
    redirect_to logout_path
  end

private
  def room_params
    params.require(:room).permit(:location, :price, :user_id)
  end
end