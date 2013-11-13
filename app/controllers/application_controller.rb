class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_filter :cors_set_access_control_headers
  

  def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'# need to be changed once it goes to production 'http://localhost:8080'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
        headers['Access-Control-Max-Age'] = "1728000"
      end 
  
  def update_message_user_names()
    @messages = Message.all
    @users = User.all
    @messages.each do |m|
       @users.each do |u|
         if m.from == u.phone
           m.user_name = u.name 
           m.save 
         end 
       end
    end
  end
end
