class User < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :timeoutable
  enum role: [:user, :trainer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.search(query)
  	where("lower(name) like ? OR lower(email) like ?", "%#{query}%".downcase, "%#{query}%".downcase)
	end

  def after_sign_in
    current_user.create_activity :sign_in, owner: current_user
  end

  def before_logout
    current_user.create_activity :sign_out, owner: current_user
  end

end
