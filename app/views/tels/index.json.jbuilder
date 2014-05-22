json.array!(@tels) do |tel|
  json.extract! tel, :id
  json.url tel_url(tel, format: :json)
end
