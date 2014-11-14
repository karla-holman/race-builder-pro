json.array!(@last_wins) do |last_win|
  json.extract! last_win, :id
  json.url last_win_url(last_win, format: :json)
end
