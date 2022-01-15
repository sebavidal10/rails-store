class CheckoutsController < ApplicationController
    def create
        orders = Order.where(user: current_user).where(payed: false)
        total = orders.map{ |order| order.stock.price }.sum
        items = get_items_hash(orders)

        @payment = PayPal::SDK::REST::Payment.new({
            :intent =>  "sale",
            :payer =>  {
                :payment_method =>  "paypal" 
            },
            :redirect_urls => {
                :return_url => complete_url,
                :cancel_url => "http://localhost:3000/cart" 
            },
            :transactions =>  [{
                :item_list => {
                    :items => items
                },
                :amount =>  {
                    :total =>  total.to_s,
                    :currency =>  "USD" 
                },
                :description =>  "Shopping Cart" 
            }]
        })

        if @payment.create
            redirect_url = @payment.links.find{|v| v.method =="REDIRECT" }.href
            redirect_to redirect_url
        else
            render json: payment.error
        end
    end

    def complete

    end

    private
    def get_items_hash(orders)
      items = orders.map do |order|
        item = {}
        item[:name] = order.stock.product.name
        item[:sku] = order.stock.product.id.to_s
        item[:price] = order.stock.price.to_s
        item[:currency] = 'USD'
        item[:quantity] = 1
        item
      end
    end
end