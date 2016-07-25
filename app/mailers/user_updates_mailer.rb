class UserUpdatesMailer < ApplicationMailer

  def signup_email(user)
    @user = user
    mail( :to => @user.email, :subject => 'Thanks for joining Chirp' )
  end

end
