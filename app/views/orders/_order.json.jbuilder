json.extract! order, :id, :payed, :pay_way, :pay_date, :user_id, :stock_id, :created_at, :updated_at
json.url order_url(order, format: :json)
