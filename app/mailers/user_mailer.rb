class UserMailer < ActionMailer::Base
  default from: "bob@codeforamerica.org"

  def reminder_email(user)
    @user = user
    mail(:to => user.email, :subject => "New CFA Surveys Available")
  end
end
