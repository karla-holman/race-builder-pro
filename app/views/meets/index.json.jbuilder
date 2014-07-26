json.array!(@meets) do |meet|
  json.extract! meet, :id
  json.url meet_url(meet, format: :json)
end
