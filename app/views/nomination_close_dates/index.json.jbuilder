json.array!(@nomination_close_dates) do |nomination_close_date|
  json.extract! nomination_close_date, :id
  json.url nomination_close_date_url(nomination_close_date, format: :json)
end
