class PassionateMailer < ApplicationMailer


 def welcome_email(passionate,password)
    @passionate = passionate
    @password = password
    @url  = 'http://bokrana.com/login'
    mail(to: @passionate.email, subject: 'Welcome to Bokrana.com')
  end





end
