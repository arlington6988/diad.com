require 'json'

class ReceiptMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'https://www.deathisadialogue.com/log-in'
    mail(to: @user.email, subject: 'Thanks from the band')
  end

#  def send_receipt(total, subtotal, tax, body, email)
  def send_receipt(email, body, user)
    @user = user
    @body = body[:amount]
    puts "body one"
    puts @body
    @body2 = body[:user][:name]
    puts "body 2"
    puts @body2

   mail(to: @user.email, subject: 'Thanks for your purchase')


  end
end
