unless User.count > 0
  ["Sherry Pace", "Boris Gardner", "Vicente Taggart", "Matte Aptekar", "Jack Cassel",
   "Kevin Jenkins", "Zoe Dholakia", "Jay Wilds", "Eadon Eastman", "Franky Weber", "Luis Helene",
   "James Rainone"].each do |name|
     first_name, last_name = name.split(" ")[0], name.split(" ")[1]
     email = "#{first_name}.#{last_name}@gmail.com"

     User.create(first_name: first_name, last_name: last_name, email: email, password: "foobar15")
   end
end

Assignment.delete_all

%w(Sherry Boris Vicente Matte Jack Sherry Matte Kevin Kevin Vicente Zoe Kevin Matte Zoe Jay Boris Eadon Sherry Franky Sherry Matte Franky Franky Kevin Boris Franky Vicente Luis Eadon Boris Kevin Matte Jay James Kevin Sherry Sherry Jack Sherry Jack).each.with_index do |first_name, index|

  user          = User.where(first_name: first_name).first
  date          = Date.today + index.days
  month         = date.month
  day           = date.day
  year          = date.year
  calendar_date = CalendarDate.where(month: month, day: day, year: year).first

  Assignment.create(calendar_date: calendar_date, user: user)

end
