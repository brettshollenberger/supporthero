angular
  .module('supporthero')
  .directive('selectedDate', ['User', function(User) {
    return {
      templateUrl: "views/directives/selected_date.html",
      link: function(scope, element, attrs) {
        scope.$watch('selectedDate', function() {
          scope.assignedUserId       = undefined;
          scope.reassignmentFeedback = undefined;
          scope.reassignedFeedback   = undefined;
        });

        scope.provideFeedback = function(selectedDate, assignedUserId) {
          if (userCanWork(selectedDate, assignedUserId)) {
            scope.reassignmentFeedback = userCanWorkMessage(assignedUserId);
          } else {
            scope.reassignmentFeedback = userCannotWorkMessage(assignedUserId);
          }
        }

        scope.reassign = function(selectedDate, assignedUserId) {
          if (userCanWork(selectedDate, assignedUserId)) {
            selectedDate.assignment.$update({user_id: assignedUserId});

            scope.reassignedFeedback = "You have reassigned this shift.";
          } else {
          }

          scope.selectedDate.assignment.reassign = false;
        }

        function userCanWork(selectedDate, userId) {
          var availableIds = availableUserIds(selectedDate),
              userId       = parseFloat(userId);

          return _.include(availableIds, userId);
        }

        function userCanWorkMessage(userId) {
          var user = findUser(userId);

          return user.fullName() + " is available to work. Click submit to save.";
        }

        function userCannotWorkMessage(userId) {
          var user = findUser(userId);

          return user.fullName() + " is not available to work. Click submit to ask " + user.first_name + " to cover the shift.";
        }

        function availableUserIds(selectedDate) {
          return _.map(selectedDate.availabilities, function(a) { return a.user.id; });
        }

        function findUser(userId) {
          return User.cached.find(userId);
        }
      }
    }
  }]);
