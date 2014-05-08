class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :trainer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.search(query)
  	where("lower(name) like ? OR lower(email) like ?", "%#{query}%".downcase, "%#{query}%".downcase)
	end

end
