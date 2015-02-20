angular
  .module('supporthero')
  .directive('reassignmentCheckbox', ['User', 'Availability', function(User, Availability) {
    return {
      scope: {
        selectedDate: "=",
        currentUser: "="
      },
      templateUrl: "views/directives/availability_checkbox.html",
      link: function(scope, element, attrs) {

        scope.$watch("selectedDate", function() {
          scope.available = scope.currentUserIsAvailable(scope.selectedDate);
        });

        scope.currentUserIsAvailable = function(selectedDate) {
          if (_.isUndefined(selectedDate)) { return false; }

          return !_.isUndefined(currentUsersAvailability(selectedDate));
        }

        scope.changeAvailability = function(selectedDate) {
          if (scope.available) {
            Availability.$create({user_id: scope.currentUser.id, calendar_selectedDate: selectedDate.id})
                        .subscribe(function(availability) {
                          selectedDate.availabilities.push(availability);
                        });
          } else {
            var availability = currentUsersAvailability(selectedDate);

            availability.$delete();

            var index = selectedDate.availabilities.indexOf(availability);

            if (index > -1) {
              selectedDate.availabilities.splice(index, 1);
            }
          }
        }

        function currentUsersAvailability(selectedDate) {
          if (_.isUndefined(selectedDate)) { return; }

          return _.chain(selectedDate.availabilities)
                  .select(function(availability) {
                    return availability.user == scope.currentUser;
                  })
                  .first()
                  .value();
        }

      }
    }
  }]);
