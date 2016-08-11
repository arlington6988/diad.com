class ChargesController < ApplicationController
before_action :checklogin

PRODUCT_COST = {
  "1" => 100,
  "2" => 4900,
  "003" => 500000
}

  def charge_card
    transaction_api = SquareConnect::TransactionApi.new()
    
    #check if product exists
   # if !PRODUCT_COST.has_key? params[:cart_id]
   #   render json: {:status => 400, :errors => [{"detail": "Product unavailable"}]  }
   #   return
   # end
#    amount = PRODUCT_COST[params[:cart_id]]
    #amount = @current_user.cart.total.to_i
    items = @current_user.cart.items.count
    amount = @current_user.cart.total.to_i
    tax = (amount * 0.07)
    amount = (tax.to_i + amount)
    shipping = items * 100
    amount = (amount + shipping)

    request_body = {
      :card_nonce => params[:card_nonce],
      :amount_money => {
        :amount => amount,
        :currency => 'USD'
      },
      :idempotency_key => SecureRandom.uuid
    }

    # The SDK throws an exception if a Connect endpoint responds with anything besides 200 (success).
    # This block catches any exceptions that occur from the request.
    locationApi = SquareConnect::LocationApi.new()
    locations = locationApi.list_locations(Rails.application.secrets.square_access_token)
    begin
      resp = transaction_api.charge(Rails.application.secrets.square_access_token, locations.locations[0].id, request_body)
    rescue SquareConnect::ApiError => e
      puts 'Error encountered while charging card:'
      puts e.message
      render json: {:status => 400, :errors => JSON.parse(e.response_body)["errors"]  }
      return
    end
    puts resp
    data = {
      amount: amount, 
      user: {
        name: params[:name], 
        street_address_1: params[:street_address_1], 
        street_address_2: params[:street_address_2], 
        state: params[:state],
        zip: params[:zip],
        city: params[:city]  
      },
      card: resp.transaction.tenders[0].card_details.card
    }

    # send receipt email to user
#    ReceiptMailer.charge_email(params[:email],data).deliver_now if Rails.env == "development"
    ReceiptMailer.send_receipt(params[:email], data, @current_user, tax, shipping).deliver_now
    @current_user.cart.items.delete_all
    @current_user.cart.total = 0
    @current_user.cart.save

   # render json: {:status => 200}
     flash[:chargestatus] = "True"
     redirect_to root_url

  end
  def checklogin
    unless current_user
      redirect_to log_in_path
    end
  end

#  def additemtocart
#    Item.additem(params[:id], '1')
#  end
end
