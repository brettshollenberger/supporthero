# SupportHero Spec

* Display the user assigned to SupportHero for a given day

* Display a calendar view for the current month

* Current user should see the days they are assigned to at a glance (green icon in the corner of the day they are assigned to)

* Non-admin users should be able to mark days that they are available to work

* Users should not be able to mark days in the past as days they are available to work

* Admin user should see upcoming (within 2 weeks) unassigned days at a glance (red icon in the corner of the day that is not assigned). 

* Since all upcoming days are assigned now with seed data, you can produce the above behavior by running:

```ruby
rails console

CalendarDate.where(month: 2, day: 20, year: 2015).first.assignment.destroy
```

This will cause 2/20/2015, an upcoming date, to be unassigned, causing it to be marked with the red icon for the admin user (stephen@newrelic.com).

* Admin should be able to assign users to shifts with absolute power.

* Admin should be notified as they are assigning a shift as to which users are available.

* Admin should receive a warning if they are assigning a user to a shift that the user has not marked asavailable, but admin should be allowed to assign the shift no matter what.

* Users should be notified (via the notifications sidebar) when they are assigned a new shift.

* Users should receive a special notification (via the notifications sidebar) when they are assigned a shift that they did not mark as available.

* Users should be able to dismiss these notifications, and should continue to see the notification until they dismiss it.

* Non-admin users should be able to give a shift they are assigned to to another user that is available to work the shift (by clicking "I cannot work" on the shift, and reassigning).

* If a user reassigns the shift to another available user, the other user should be assigned.

* Non-admin users should be able to request that an unavailable user take their shift. 

* The unavailable user should receive a request notification (via the notifications sidebar) to pick up the shift they are not available for. 

* The unavailable user should be able to accept the shift.

* The unavailable user should be able to decline the shift.

* Non-admin users should not be able to reassign shifts to which they are not assigned.

* The system should do no automatic assigning of shifts. The most user-friendly experience (in my opinion) is to utilize a system of notifications and availabilities to allow users to assign shifts (and to not receive shifts they are not available for unless an admin requires it).

#### Application Future:

* If I were to continue developing this application, I would want to add:

  * Additional notifications for other user actions (user accepted/declined shift request)
  * A Cron job to add new calendar years
  * Email notifications for users
  * User settings to specify the types of notifications they wish to receive, and how they wish to receive them

#### Users:

 * Stephen Rogers (admin) - stephen@newrelic.com / password: "foobar15"
 * Sherry Pace
 * Boris Gardner
 * Vicente Taggart
 * Matte Aptekar
 * Jack Cassel
 * Kevin Jenkins
 * Zoe Dholakia
 * Jay Wilds
 * Eadon Eastman
 * Franky Weber
 * Luis Helene
 * James Rainone

All other users have email: "#{first_name}.#{last_name}@gmail.com" (e.g. sherry.pace@gmail.com) and password: "foobar15"

