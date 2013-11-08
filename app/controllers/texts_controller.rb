class TextsController < ApplicationController
  def index 
     respond_to do |format|
       format.html {render :text =>"hello texts"}
     end
  end

end
