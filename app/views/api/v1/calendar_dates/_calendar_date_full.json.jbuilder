json.partial! 'api/v1/calendar_dates/calendar_date', calendar_date: calendar_date

unless calendar_date.holiday.nil?
  json.holiday calendar_date.holiday.name
end

json.assignable calendar_date.assignable?
json.upcoming calendar_date.upcoming?

json.assignment do
  unless calendar_date.assignment.nil?
    json.partial! 'api/v1/assignments/assignment_short', assignment: calendar_date.assignment
  end
end

json.availabilities do
  json.array! calendar_date.availabilities, partial: 'api/v1/availabilities/availability_short', as: :availability
end
