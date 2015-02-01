json.array!(@condition_nodes) do |condition_node|
  json.extract! condition_node, :id
  json.url condition_node_url(condition_node, format: :json)
end
