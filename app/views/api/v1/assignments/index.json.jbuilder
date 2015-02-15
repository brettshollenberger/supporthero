json.url api_v1_assignments_path
json.array! @assignments, partial: 'api/v1/assignments/assignment', as: :assignment
