json.array!(@race_conditions) do |race_condition|
  json.extract! race_condition, :id, :race_id, :condition_id, :value
  json.url race_condition_url(race_condition, format: :json)
end
