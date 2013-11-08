require 'twilio-ruby'

class TextsController < ApplicationController
  def index 
     message_body = params["Body"]
     from_number = params["From"]
     number_to_send_to = from_number

         twilio_sid = "ACa09a74cf7aa3479773f1f4fb0ac4a936"
         twilio_token = "0f8ff6f9e8fb73b2c5b7b41664960cde"
         twilio_phone_number = "3147202048"

         @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

         @twilio_client.account.sms.messages.create(
           :from => "+1#{twilio_phone_number}",
           :to => number_to_send_to,
           :body => "This is a message. It gets sent to #{number_to_send_to}"
         )
     
     
     # respond_to do |format|
     #        format.html {render :text =>"#{twiml.text}"}
     #      end 
  end

end
