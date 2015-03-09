json.array!(@horse_filter_settings) do |horse_filter_setting|
  json.extract! horse_filter_setting, :id
  json.url horse_filter_setting_url(horse_filter_setting, format: :json)
end
