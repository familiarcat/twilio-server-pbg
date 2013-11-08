require 'twilio-ruby'

class CallsController < ApplicationController
  
  # {:AccountSid "ACa09a74cf7aa3479773f1f4fb0ac4a936", 
  #     :ToZip "63141", :FromState "MO", :Called "+13147202048", 
  #     :FromCountry "US", :CallerCountry "US", :CalledZip "63141", 
  #     :Direction "inbound", :FromCity "LADUE", :CalledCountry "US", 
  #     :CallerState "MO", :CallSid "CAa8b944661cae8d17c802f111f2d36574", 
  #     :CalledState "MO", :From "+13145800608", :CallerZip "63124", 
  #     :FromZip "63124", :CallStatus "ringing", :ToCity "CREVE COEUR", 
  #     :ToState "MO", :To "+13147202048", :ToCountry "US", 
  #     :CallerCity "LADUE", :ApiVersion "2010-04-01", 
  #     :Caller "+13145800608", :CalledCity "CREVE COEUR"}
  
  def index
    create
  end
  
  def messages
     @from_number = params[:From] 
     @user = User.where(phone: @from_number).take 
     message_number = 1;
     @twiml = Twilio::TwiML::Response.new do |r|
       @user.messages.each do |m|
          r.Say "Message number: #{message_number}"
          r.Say "#{m.text}"
          r.Pause
          r.Pause
          message_number+=1
       end
       r.Say "Thanks for calling. Goodbye?"
     end
     
     respond_to do |format|
       format.html do 
          puts "#{@twiml.text}"
          render :xml => "#{@twiml.text}", :layout=>false;
       end
     end
  end
    
  def create
    @from_number = params[:From]
     @to_number  = params[:To]
     @body = params[:Body]
     @user = User.where(phone: @from_number).take
     if !@user
        @user = User.new(:phone=>@from_number)
     end
     @user.save
     new_messages = @user.messages.length > 0;
     twiml = Twilio::TwiML::Response.new do |r|
       gather = r.Gather(:action=>"calls/messages", :numDigits=>"1", :timeout=>"30") do |g|
         r.Say "Thanks for checking in."
         r.Say  "You have #{@user.messages.length} messages."
         if new_messages then r.Say "Press 1 to listen to them." end
       end
     end
     
     respond_to do |format|
         format.html do 
           
           render :xml => "#{twiml.text}", :layout=>false;
         end
      end   
  end
end
