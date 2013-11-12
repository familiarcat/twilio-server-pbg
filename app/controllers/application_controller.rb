class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
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
