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
         r.Message "I got it! Your note has been heard loud and clear. Your promotional code for this message is #{@message.id}. Call (314) 720-2048 to hear your notes."
       end
     respond_to do |format|
        format.html do 
          render :xml => "#{twiml.text}"
        end
     end
  end

end
