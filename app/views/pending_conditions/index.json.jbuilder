json.array!(@pending_conditions) do |pending_condition|
  json.extract! pending_condition, :id
  json.url pending_condition_url(pending_condition, format: :json)
end
