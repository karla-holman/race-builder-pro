class CreateOwnerService
  def call
    user = User.find_or_create_by!(email: "owner@hopemediahouse.com") do |user|
        user.password = "testing123"
        user.password_confirmation = "testing123"
        user.name = "RBP Owner"
        user.phone = "222-222-2222"

        user.user!
      end
  end
end
