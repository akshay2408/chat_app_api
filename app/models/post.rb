class Post < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  after_create :chat_update

    def chat_update
        ActionCable
        .server
        .broadcast("rooms_#{self.channel.id}_channel",
                    {id: self.id,
                    created_at: self.created_at.strftime('%H:%M'),
                    content: self.content})
    end
end
