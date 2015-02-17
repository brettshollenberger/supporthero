json.id assignment.id
json.url api_v1_assignment_path(assignment)

json.user do
  json.partial! 'api/v1/users/user', user: assignment.user
end

json.calendar_date do
  json.partial! 'api/v1/calendar_dates/calendar_date', calendar_date: assignment.calendar_date
end
