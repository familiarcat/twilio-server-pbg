require 'test_helper'

class TextsControllerTest < ActionController::TestCase

  def setup
      User.delete_all
      Message.delete_all
  end
  
  test "should_parse_twilio_text" do
    post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", MessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", Body: "G", ToZip: "63141", ToCity: "CREVE COEUR", FromState: "MO", ToState: "MO", SmsSid: "SMa37c801829834e9b3f07d18b4ad3054b", To: "+13147202048", ToCountry: "US", FromCountry: "US", SmsMessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", ApiVersion: "2010-04-01", FromCity: "LADUE", SmsStatus: "received", NumMedia: "0", From: "+13145800608", FromZip: "63124"}
    assert_response :success
    assert_not_nil assigns :from_number
    assert_not_nil assigns :to_number
    assert_not_nil assigns :body
    assert_not_nil assigns :user
    assert_not_nil assigns :message
  end
  
  test "should_make_unique_user_by_phone_number" do
    assert_difference('User.count') do
     post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", MessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", Body: "G", ToZip: "63141", ToCity: "CREVE COEUR", FromState: "MO", ToState: "MO", SmsSid: "SMa37c801829834e9b3f07d18b4ad3054b", To: "+13147202048", ToCountry: "US", FromCountry: "US", SmsMessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", ApiVersion: "2010-04-01", FromCity: "LADUE", SmsStatus: "received", NumMedia: "0", From: "+13145800608", FromZip: "63124"}
    end
    assert_no_difference('User.count') do
     post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", MessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", Body: "G", ToZip: "63141", ToCity: "CREVE COEUR", FromState: "MO", ToState: "MO", SmsSid: "SMa37c801829834e9b3f07d18b4ad3054b", To: "+13147202048", ToCountry: "US", FromCountry: "US", SmsMessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", ApiVersion: "2010-04-01", FromCity: "LADUE", SmsStatus: "received", NumMedia: "0", From: "+13145800608", FromZip: "63124"}
   end
  end              
  
  test "should_make_new_message_for_user_from_text" do
    assert_difference('Message.count') do
     post :create, {AccountSid: "ACa09a74cf7aa3479773f1f4fb0ac4a936", MessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", Body: "G", ToZip: "63141", ToCity: "CREVE COEUR", FromState: "MO", ToState: "MO", SmsSid: "SMa37c801829834e9b3f07d18b4ad3054b", To: "+13147202048", ToCountry: "US", FromCountry: "US", SmsMessageSid: "SMa37c801829834e9b3f07d18b4ad3054b", ApiVersion: "2010-04-01", FromCity: "LADUE", SmsStatus: "received", NumMedia: "0", From: "+13145800608", FromZip: "63124"}
     assert Message.count == 1 , "#{Message.count}"
    end
  end
end
