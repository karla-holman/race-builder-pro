json.array!(@conditions) do |condition|
  json.extract! condition, :id, :name, :category_id
  json.url condition_url(condition, format: :json)
end
