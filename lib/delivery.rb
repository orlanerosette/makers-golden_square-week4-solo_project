require 'dotenv'
require 'twilio-ruby'
Dotenv.load

class Delivery
  def initialize(terminal)
    @terminal = terminal
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_message
    message = @client.messages.create(
      body: "Thank you! Your order was placed and will be delivered before #{(Time.now + 3000).strftime("%H:%M")}",
      from: ENV['twilio_number'],
      to: ENV['phone']
      )
    @terminal.puts message.sid
  end
end

# Delivery.new(Kernel).send_message