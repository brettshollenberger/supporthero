json.partial! 'api/v1/calendar_dates/calendar_date', calendar_date: calendar_date

json.assignment do
  unless calendar_date.assignment.nil?
    json.partial! 'api/v1/assignments/assignment_short', assignment: calendar_date.assignment
  end
end

json.availabilities do
  json.array! calendar_date.availabilities, partial: 'api/v1/availabilities/availability_short', as: :availability
end
