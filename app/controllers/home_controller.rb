class HomeController < ApplicationController
before_filter :authenticate_user!, :except => [:index]
layout "home"

  def index
    
  end

	
end
