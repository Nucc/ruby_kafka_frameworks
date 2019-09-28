class SendProfileUpdateNotification < ApplicationResponder
  topic :user_profile_update_notifications, required: true

  def respond(data)
    puts "Sending user profile update notifications #{data}"
    respond_to :user_profile_update_notifications, data
    sleep 0.5
  end
end