class HomeController < ApplicationController
  def index
    @users = User.all
    @races = Race.all
    all_suggestions = Notification.where(:action => "Suggest")
    @nominations = Notification.where(:action => "Nominate")
    @condition_requests = Notification.all - all_suggestions - @nominations
    
    if current_user.trainer?
    	@horses = Horse.where(:trainer_id => current_user.id)
        horse_ids = @horses.pluck(:id)
        @suggestions = all_suggestions.where("recv_id IN (?)", horse_ids)
    elsif current_user.user?
    	@horses = Horse.where(:owner_id => current_user.id)
        horse_ids = @horses.pluck(:id)
        @suggestions = all_suggestions.where("recv_id IN (?)", horse_ids)
    end
  end
end
