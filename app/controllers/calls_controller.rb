class CallsController < ApplicationController
  def index
    respond_to do |format|
      format.html {render :text =>"hello calls"}
    end
  end
end
