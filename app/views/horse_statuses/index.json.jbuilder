json.array!(@horse_statuses) do |horse_status|
  json.extract! horse_status, :id, :horse_id, :status_id
  json.url horse_status_url(horse_status, format: :json)
end
