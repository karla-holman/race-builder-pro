class HomeController < ApplicationController
  def index
    @users = User.all
    all_suggestions = Notification.where(:action => "Suggest")
    @nominations = Notification.where(:action => "Nominate")
    @condition_requests = Notification.all - all_suggestions - @nominations

    today = Date.today()
    
    sunday1 = today.beginning_of_week().days_ago(1)
    friday1 = sunday1.days_ago(2)
    @previous_races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", sunday1.end_of_day, friday1.beginning_of_day)
    
    sunday2 = sunday1 + 7.day
    friday2 = sunday2.days_ago(2)
    @next_races = Race.where("race_datetime <= (?) AND race_datetime >= (?)", sunday2.end_of_day, friday2.beginning_of_day)
    
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
