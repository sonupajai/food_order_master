json.array!(@notifications) do |notification|
  json.extract! notification, :id, :messagge, :String, :User_id, :String
  json.url notification_url(notification, format: :json)
end
