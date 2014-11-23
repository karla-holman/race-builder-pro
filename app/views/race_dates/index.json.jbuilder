json.array!(@race_dates) do |race_date|
  json.extract! race_date, :id
  json.url race_date_url(race_date, format: :json)
end
