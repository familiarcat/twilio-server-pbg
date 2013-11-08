require 'twilio-ruby'

class TextsController < ApplicationController
  protect_from_forgery :except => ["create"]
  
  def create
     @from_number = params[:From]
     @to_number  = params[:To]
     @body = params[:Body]
     @user = User.where(phone: @from_number).take
     if !@user
        @user = User.new(:phone=>@from_number)
     end
     @message = Message.new(to: @to_number, from: @from_number, text: @body)
     @user.messages.push(@message)
     @message.save
     @user.save
     twiml = Twilio::TwiML::Response.new do |r|
         r.Message "I got it! Your message has been heard loud and clear."
       end
     respond_to do |format|
        format.html do 
          render :xml => "#{twiml.text}"
        end
     end
  end

end
