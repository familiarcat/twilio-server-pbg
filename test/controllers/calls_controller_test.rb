require 'test_helper'

class CallsControllerTest < ActionController::TestCase
  
  def setup
      User.delete_all
      Message.delete_all
  end
  
  test "should_parse_twilio_call" do
    post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", ToZip: "63141", FromState: "MO", Called: "+13147202048", FromCountry: "US", CallerCountry: "US", CalledZip: "63141", Direction: "inbound", FromCity: "LADUE", CalledCountry: "US", CallerState: "MO", CallSid: "CAa8b944661cae8d17c802f111f2d36574", CalledState: "MO", From: "+13145800608", CallerZip: "63124", FromZip: "63124", CallStatus: "ringing", ToCity: "CREVE COEUR", ToState: "MO", To: "+13147202048", ToCountry: "US", CallerCity: "LADUE", ApiVersion: "2010-04-01", Caller: "+13145800608", CalledCity: "CREVE COEUR"}
    assert_response :success
    assert_not_nil assigns :from_number
    assert_not_nil assigns :to_number
    assert_not_nil assigns :user
  end
  
  test "should_make_unique_user_by_phone_number" do
    assert_difference('User.count') do
     post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", ToZip: "63141", FromState: "MO", Called: "+13147202048", FromCountry: "US", CallerCountry: "US", CalledZip: "63141", Direction: "inbound", FromCity: "LADUE", CalledCountry: "US", CallerState: "MO", CallSid: "CAa8b944661cae8d17c802f111f2d36574", CalledState: "MO", From: "+13145800608", CallerZip: "63124", FromZip: "63124", CallStatus: "ringing", ToCity: "CREVE COEUR", ToState: "MO", To: "+13147202048", ToCountry: "US", CallerCity: "LADUE", ApiVersion: "2010-04-01", Caller: "+13145800608", CalledCity: "CREVE COEUR"}
    end
    assert_no_difference('User.count') do
     post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", ToZip: "63141", FromState: "MO", Called: "+13147202048", FromCountry: "US", CallerCountry: "US", CalledZip: "63141", Direction: "inbound", FromCity: "LADUE", CalledCountry: "US", CallerState: "MO", CallSid: "CAa8b944661cae8d17c802f111f2d36574", CalledState: "MO", From: "+13145800608", CallerZip: "63124", FromZip: "63124", CallStatus: "ringing", ToCity: "CREVE COEUR", ToState: "MO", To: "+13147202048", ToCountry: "US", CallerCity: "LADUE", ApiVersion: "2010-04-01", Caller: "+13145800608", CalledCity: "CREVE COEUR"}
   end
  end
  
  test "should_play_messages" do
     user = User.new(:name=>"Bob", :phone=>"+13145800608")
     user.save
     user.messages.push(Message.new(:text=>"Hello World"))
     
     post :messages, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", ToZip: "63141", FromState: "MO", Called: "+13147202048", FromCountry: "US", CallerCountry: "US", CalledZip: "63141", Direction: "inbound", FromCity: "LADUE", CalledCountry: "US", CallerState: "MO", CallSid: "CA1c887b96b2d2f62091d40cece9c74fcc", CalledState: "MO", From: "+13145800608", CallerZip: "63124", FromZip: "63124", CallStatus: "in-progress", ToCity: "CREVE COEUR", ToState: "MO", To: "+13147202048", Digits: "1", ToCountry: "US", msg: "Gather End", CallerCity: "LADUE", ApiVersion: "2010-04-01", Caller: "+13145800608", CalledCity: "CREVE COEUR", controller: "calls", action: "messages"}
     #assert_match assigns(:twiml).text, '<?xml version="1.0" encoding="UTF-8"?><Response><Say>Message number: 1</Say><Say>Hello World</Say><Pause/><Pause/><Say>Thanks for calling. Goodbye?</Say></Response>'
  end
  
end
