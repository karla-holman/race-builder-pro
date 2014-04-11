class CreateOwnerService
  def call
    user = User.find_or_create_by!(email: "owner@hopemediahouse.com") do |user|
        user.password = "testing123"
        user.password_confirmation = "testing123"
        user.name = "RBP Owner"
        user.user!
      end
  end
end
