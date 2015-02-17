["Sherry Pace", "Boris Gardner", "Vicente Taggart", "Matte Aptekar", "Jack Cassel",
 "Kevin Jenkins", "Zoe Dholakia", "Jay Wilds", "Eadon Eastman", "Franky Weber", "Luis Helene",
 "James Rainone"].each do |name|
   first_name, last_name = name.split(" ")[0], name.split(" ")[1]
   email = "#{first_name}.#{last_name}@gmail.com"

   User.create(first_name: first_name, last_name: last_name, email: email, password: "foobar15")
end

Assignment.delete_all

date  = Date.today
month = date.month
day   = date.day
year  = date.year

CalendarDate.assignable.where("year = #{year} AND ((month = #{month} AND day >= #{day}) OR month > #{month})").zip(%w(Sherry Boris Vicente Matte Jack Sherry Matte Kevin Kevin Vicente Zoe Kevin Matte Zoe Jay Boris Eadon Sherry Franky Sherry Matte Franky Franky Kevin Boris Franky Vicente Luis Eadon Boris Kevin Matte Jay James Kevin Sherry Sherry Jack Sherry Jack)).each do |(date, first_name)|

  user = User.where(first_name: first_name).first

  Assignment.create(calendar_date: date, user: user)
end

[
  %w(Sherry Boris), %w(Boris Matte Jack), %w(Vicente Sherry), %w(Matte Jack Sherry), %w(Jack Franky),
  %w(Sherry Boris Luis), %w(Matte Kevin Vicente), %w(Kevin Jack Boris Luis Eadon), %w(Kevin Zoe Jay),
  %w(Vicente), %w(Zoe Kevin), %w(Kevin Sherry), %w(Matte Zoe Luis), %w(Zoe James), %w(Jay Boris Eadon),
  %w(Boris Luis James), %w(Eadon Franky Jack), %w(Sherry Zoe), %w(Franky Sherry), %w(Sherry Matte),
  %w(Matte Franky Kevin), %w(Franky Boris), %w(Franky Vicente Luis), %w(Kevin Jack Sherry),
  %w(Boris Jay James), %w(Franky Luis Eadon), %w(Vicente Zoe), %w(Luis Boris), %w(Eadon Matte),
  %w(Boris Kevin Matte), %w(Kevin Matte Jay), %w(Matte Jay James), %w(Jay Boris), %w(James Kevin),
  %w(Kevin Sherry), %w(Sherry Boris), %w(Sherry), %w(Jack Boris), %w(Sherry Matte), %w(Jack Zoe)
]
