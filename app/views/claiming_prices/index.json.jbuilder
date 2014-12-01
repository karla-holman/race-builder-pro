json.array!(@claiming_prices) do |claiming_price|
  json.extract! claiming_price, :id
  json.url claiming_price_url(claiming_price, format: :json)
end
