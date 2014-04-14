json.array!(@horseraces) do |horserace|
  json.extract! horserace, :id, :horse_id, :race_id, :entered, :created_at, :updated_at
  json.url horserace_url(horserace, format: :json)
end
