require 'json'

class ReceiptMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'https://www.deathisadialogue.com/log-in'
    mail(to: @user.email, subject: 'Thanks from the band')
  end

#  def send_receipt(total, subtotal, tax, body, email)
  def send_receipt(email, body, user, tax, shipping)
    @user = user
    @items = @user.cart.items
    @body = body[:amount]
    unless @body < 1000
    @body = @body.to_i.to_s.scan(/./)
    @body = '$' + @body[0..-3].join + '.' + @body[-2..-1].join
    else
      @body = @body.to_i.to_s.scan(/./)
      @body = '$' + @body[0].to_s + '.' + @body[-2..-1].join
      end

    puts "body one"
    puts @body
    @body2 = body[:user][:name]
    puts "body 2"
    puts @body2
    puts "shipping is below"
    puts shipping
    puts "Tax is below"
    puts tax
    @body3 = body[:user][:street_address_1]
    @body4 = body[:user][:street_address_2]
    @body6 = body[:user][:state]
    @body7 = body[:user][:zip]
    @body8 = body[:user][:city]
    @body9 = @body8 + ', ' + @body6 + ', ' + @body7
    @tax = tax
    if @tax > 100
      @tax = tax.to_i.to_s.scan(/./)
      @tax =  '$' + @tax[0..-3].join + '.' + @tax[-2..-1].join
    else
      @tax = '$' + '0.' + tax.to_i.to_s
    end
    @shipping = shipping
    @shipping = @shipping.to_i.to_s.scan(/./)
    unless @shipping.nil?
    @shipping = '$' + @shipping[0..-3].join + '.' + @shipping[-2..-1].join
    end

    mail(to: @user.email,
         bcc: ["deathisadialogue1@gmail.com"], subject: 'Thanks for your purchase')

  end
end
