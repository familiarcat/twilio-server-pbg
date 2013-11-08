xml.instruct! :xml, :version=>"1.0"

xml.Response do
  xml.Say "Thanks for calling my Demo Application."
  xml.Say "#{@from_number}"
end