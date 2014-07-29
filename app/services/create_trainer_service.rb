class CreateTrainerService
  def call
    user = User.find_or_create_by!(email: "trainer@hopemediahouse.com") do |user|
        user.password = "testing123"
        user.password_confirmation = "testing123"
        user.first_name = "RBP"
        user.last_name = "Trainer"
        user.phone = "222-222-2222"
        user.trainer!
      end
  end
end
