json.url api_v1_assignment_path(assignment)

json.user do
  json.partial! 'api/v1/users/user', user: assignment.user
end
