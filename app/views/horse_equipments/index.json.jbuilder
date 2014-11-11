json.array!(@horse_equipments) do |horse_equipment|
  json.extract! horse_equipment, :id
  json.url horse_equipment_url(horse_equipment, format: :json)
end
