json.extract! event, :id

json.eventable do
  json.type event.eventable_type

  if event.eventable_type == "Assignment"
    json.partial! 'api/v1/assignments/assignment_short', assignment: event.eventable
  end
end

json.creator do
  json.partial! 'api/v1/users/user', user: event.creator
end
