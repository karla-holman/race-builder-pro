json.array!(@condition_categories) do |condition_category|
  json.extract! condition_category, :id, :name
  json.url condition_category_url(condition_category, format: :json)
end
