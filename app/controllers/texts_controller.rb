require 'twilio-ruby'

class TextsController < ApplicationController
  def index 
     message_body = params["Body"]
     from_number = params["From"]
     twiml = Twilio::TwiML::Response.new do |r|
       r.Message "Hey Monkey. Thanks for the message!"
     end
     twiml.text
     
     respond_to do |format|
       format.html {render :text =>"#{twiml.text}"}
       format.xml {render :text=>"#{twiml.text}"}
     end
  end

end
