json.array!(@weeks) do |week|
  json.extract! week, :id
  json.url week_url(week, format: :json)
end
