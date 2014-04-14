json.array!(@races) do |race|
  json.extract! race, :id, :name, :created_at, :updated_at, :race_number
  json.url race_url(race, format: :json)
end
