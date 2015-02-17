json.id availability.id
json.url api_v1_availability_path(availability)

json.user do
  json.partial! 'api/v1/users/user', user: availability.user
end

json.calendar_date_id availability.calendar_date.id
