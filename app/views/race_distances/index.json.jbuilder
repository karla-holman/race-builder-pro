json.array!(@race_distances) do |race_distance|
  json.extract! race_distance, :id
  json.url race_distance_url(race_distance, format: :json)
end
