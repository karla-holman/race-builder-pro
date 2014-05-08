class HomeController < ApplicationController
  def index
    @users = User.all
    @races = Race.all
    
    if current_user.trainer?
    	@horses = Horse.where(:trainer_id => current_user.id)
    elsif current_user.user?
    	@horses = Horse.where(:owner_id => current_user.id)
    end	
  end
end
