class ApplicationController < ActionController::Base
  include Pundit
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def filter_range(condition, value)
    if condition.lowerbound.nil?
      if value > condition.upperbound
        return "no"
      else
        return "yes"
      end
    elsif condition.upperbound.nil?
      if value < condition.lowerbound
        return "no"
      else
        return "yes"
      end
    else
      if condition.upperbound < value || value < condition.lowerbound
        return "no"
      else
        return "yes"
      end
    end
  end
  
  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
end
