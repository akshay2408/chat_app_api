class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    @current_user.posts.create(
      content: opts.fetch('content')
    )
  end
end