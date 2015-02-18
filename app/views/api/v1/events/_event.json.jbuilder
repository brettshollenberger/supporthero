json.extract! event, :id

json.event_type event.event_type.name

json.eventable do
  json.type event.eventable_type

  if event.eventable_type == "Assignment"
    json.partial! 'api/v1/assignments/assignment_short', assignment: event.eventable
  end
end

json.calendar_date do
  json.partial! 'api/v1/calendar_dates/calendar_date', calendar_date: event.eventable.calendar_date
end

json.creator do
  json.partial! 'api/v1/users/user', user: event.creator
end
