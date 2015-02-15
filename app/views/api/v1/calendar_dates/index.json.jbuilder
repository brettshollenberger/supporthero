json.url api_v1_calendar_dates_path
json.array! @calendar_dates, partial: 'api/v1/calendar_dates/calendar_date_full', as: :calendar_date
