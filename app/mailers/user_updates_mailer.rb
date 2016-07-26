class UserUpdatesMailer < ApplicationMailer

  def signup_email(user)
    @user = user
    mail( :to => @user.email, :subject => 'Thanks for joining Chirp' )
  end

  def following_email(user, current_user)
    @userish = users
    @user2 = current_user
    mail( :to => @user.email, :subject => 'Someone has followed you on Chirp')
  end

end
