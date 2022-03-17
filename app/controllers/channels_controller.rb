class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show update destroy fetch_members ]
  before_action :authorize_user

  # GET /channels
  def index
    @channels = Channel.all

    render json: @channels
  end

  # GET /channels/1
  def show
    render json: @channel
  end

  # POST /channels
  def create
    @channel = Channel.new(title: params[:title], admin: @current_user)

    if @channel.save
      render json: @channel, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1
  def update
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
  end

  def remove_member
    @room = Room.find(params[:id])
    if @room.present? && (@room.channel.admin.eql? @current_user)
      @room.destroy
    else
      render json: @room.errors, status: :unprocessable_entity
    end  
  end

  def fetch_members
    render json: @channel.users
  end  

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def channel_params
      params.permit(:title)
    end
end
