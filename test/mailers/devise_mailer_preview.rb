class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(name: 'John Doe', email: 'john@example.com', confirmation_token: 'token')
    DeviseMailer.confirmation_instructions(user, 'token')
  end
end
