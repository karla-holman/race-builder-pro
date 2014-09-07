json.array!(@horse_meets) do |horse_meet|
  json.extract! horse_meet, :id
  json.url horse_meet_url(horse_meet, format: :json)
end
