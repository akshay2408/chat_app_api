class ChannelsController < ApplicationController
  before_action :set_channel, except: %i[ index create remove_member ]
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
    if @channel.admin.eql? @current_user
      if @channel.update(channel_params)
        render json: @channel
      else
        render json: @channel.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: "Only Admin can make updates" }
    end  
  end

  # DELETE /channels/1
  def destroy
    if @channel.admin.eql? @current_user
      @channel.destroy
    else
      render json: { errors: "Only Admin can delete" } 
    end  
  end

  def remove_member
    @room = Room.find(params[:id])
    if (@room.present?) && (@room.channel.admin.eql? @current_user)
      @room.destroy
    else
      render json: {error: "The member can't be removed"}
    end  
  end

  def fetch_members
    render json: @channel.users
  end  

  def count_messages
    render json: {
      count: @channel.posts.count,
      last_message_at: @channel.posts.last.created_at,
    }
  end  

  def all_messages
    render json: @channel.posts
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
