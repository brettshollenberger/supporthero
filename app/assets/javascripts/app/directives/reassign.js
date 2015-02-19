angular
  .module('supporthero')
  .directive('reassign', ['User', 'Event', function(User, Event) {
    return {
      scope: {
        selectedDate: '=date',
      },
      templateUrl: "views/directives/reassign.html",
      link: function(scope, element, attrs) { 
        scope.$watch('selectedDate', function() {
          scope.assignedUserId       = undefined;
          scope.reassignmentFeedback = undefined;

          if (!_.isUndefined(scope.selectedDate)) {
            var availableUsers  = _.map(scope.selectedDate.availabilities, function(a) { return a.user; }),
                allUsers        = _.values(User.cached),
                currentUser     = User.cached["current_user"],
                assignableUsers = _.chain(allUsers)
                                   .uniq()
                                   .select(function(user) {
                                     return user != currentUser;
                                   })
                                   .map(function(user) {
                                     return {
                                       available: _.include(availableUsers, user) ? "available" : "unavailable",
                                       user: user
                                     }
                                   })
                                   .groupBy(function(assignable) {
                                     return assignable.available;
                                   })
                                   .value();

            scope.assignableUsers = assignableUsers;
          }
        });

        scope.provideFeedback = function(selectedDate, assignedUserId) {
          if (userCanWork(selectedDate, assignedUserId)) {
            scope.reassignmentFeedback = userCanWorkMessage(assignedUserId);
            scope.assignable = true;
          } else {
            scope.reassignmentFeedback = userCannotWorkMessage(assignedUserId);
            scope.assignable = false;
          }
        }

        scope.reassign = function(selectedDate, assignedUserId) {
          if (User.currentUserIsAdmin() || userCanWork(selectedDate, assignedUserId)) {
            selectedDate.assignment.$update({user_id: assignedUserId});
          } else {
            Event.$create({
              event_type: "request to switch",
              eventable_type: "Assignment",
              eventable_id: selectedDate.assignment.id,
              creator_id: User.cached["current_user"].id,
              recipient_ids: [assignedUserId]
            })
          }

          scope.selectedDate.assignment.reassign = false;
          scope.reassignmentFeedback = undefined;

          deleteUsersAvailability(scope.selectedDate.availabilities);
        }

        function deleteUsersAvailability(availabilities) {
          var availability = _.select(availabilities, function(a) { 
            return a.user == User.cached["current_user"]; 
          })[0];

          if (!_.isUndefined(availability)) {
            availability.$delete();
          }
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
          var user                = findUser(userId),
              notAvailable        = user.fullName() + " is not available to work.",
              normalUserMessage   = "Click submit to ask " + user.first_name + " to cover the shift.",
              adminMessage        = "If you assign " + user.first_name + ", " + user.first_name + " will receive a notification.",
              userSpecificMessage = User.currentUserIsAdmin() ? adminMessage : normalUserMessage;

          return notAvailable + " " + userSpecificMessage;
        }

        function availableUserIds(selectedDate) {
          return _.map(selectedDate.availabilities, function(a) { return a.user.id; });
        }

        function findUser(userId) {
          return User.cached.find(userId);
        }
      }
    }
  }])
