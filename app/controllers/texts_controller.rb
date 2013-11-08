require 'twilio-ruby'

class TextsController < ApplicationController
  def index 
     twiml = Twilio::TwiML::Response.new do |r|
         r.Message "Hey Monkey. Thanks for the message!"
       end
      twiml.text
  end

end
