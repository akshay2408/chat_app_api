class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy read_message ]
  before_action :authorize_user
  before_action :set_channel, only: %i[ create ]
  after_action :create_member, only: %i[ create ]
  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create

    @post = @current_user.posts.new(content: params[:content], channel_id: @channel.id)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    if (@post.user.eql? @current_user) || (@post.channel.admin.eql? @current_user)
      @post.destroy
      render json: { errors: "Message has been deleted" }
    else 
      render json: { errors: "Message can only be deleted by either admin or owner of message" }
    end  
  end

  def create_member
    @room = Room.create(user: @current_user, channel: @channel)
  end  

  def read_message
    if @post.update(read_status: true)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_channel
      @channel = Channel.find(params[:channel_id].to_i)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:content, :read_status, :user_id, :channel_id)
    end
end
