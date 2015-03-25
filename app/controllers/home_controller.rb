class HomeController < ApplicationController
  def index
    @users = User.all
    @inactive = Status.find_by_name('Inactive')
    all_suggestions = Notification.where(:action => "Suggest")
    @nominations = Notification.where(:action => "Nominate")
    @condition_requests = Notification.all - all_suggestions - @nominations

    @races = FilterRacesService.new.currentEligibleRaces()

    @tels = Tel.where('entry_list = ? AND date >= ? AND published = ?', false, Date.today, true)

    if current_user.trainer?
    	@horses = Horse.where(:trainer_id => current_user.id).where.not(:status => @inactive)
        horse_ids = @horses.pluck(:id)
        @suggestions = all_suggestions.where("recv_id IN (?)", horse_ids)
    elsif current_user.user?
    	@horses = Horse.where(:owner_id => current_user.id).where.not(:status => @inactive)
        horse_ids = @horses.pluck(:id)
        @suggestions = all_suggestions.where("recv_id IN (?)", horse_ids)
    end
  end
end
