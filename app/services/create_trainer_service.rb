class CreateTrainerService
  def call
    user = User.find_or_create_by!(email: "trainer@hopemediahouse.com") do |user|
        user.password = "testing123"
        user.password_confirmation = "testing123"
        user.name = "RBP Trainer"
        user.trainer!
      end
  end
end
