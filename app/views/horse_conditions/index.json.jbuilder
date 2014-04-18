json.array!(@horse_conditions) do |horse_condition|
  json.extract! horse_condition, :id, :horse_id, :condition_id, :value
  json.url horse_condition_url(horse_condition, format: :json)
end
