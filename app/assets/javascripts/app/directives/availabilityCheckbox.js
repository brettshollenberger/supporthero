angular
  .module('supporthero')
  .directive('availabilityCheckbox', ['User', 'Availability', function(User, Availability) {
    return {
      scope: {
        date: "=",
        currentUser: "="
      },
      templateUrl: "views/directives/availability_checkbox.html",
      link: function(scope, element, attrs) {

        scope.$watch("date", function() {
          scope.available = scope.currentUserIsAvailable(scope.date);
        });

        scope.currentUserIsAvailable = function(date) {
          if (_.isUndefined(date)) { return false; }

          return !_.isUndefined(currentUsersAvailability(date));
        }

        scope.changeAvailability = function(date) {
          if (scope.available) {
            Availability.$create({user_id: scope.currentUser.id, calendar_date_id: date.id})
                        .subscribe(function(availability) {
                          date.availabilities.push(availability);
                        });
          } else {
            var availability = currentUsersAvailability(date);

            availability.$delete();

            var index = date.availabilities.indexOf(availability);

            if (index > -1) {
              date.availabilities.splice(index, 1);
            }
          }
        }

        function currentUsersAvailability(date) {
          if (_.isUndefined(date)) { return; }

          return _.chain(date.availabilities)
                  .select(function(availability) {
                    return availability.user == scope.currentUser;
                  })
                  .first()
                  .value();
        }

      }
    }
  }]);
