angular
  .module('supporthero')
  .directive('reassign', ['User', function(User) {
    return {
      scope: {
        selectedDate: '=date',
      },
      templateUrl: "views/directives/reassign.html",
      link: function(scope, element, attrs) { 
        scope.$watch('selectedDate', function() {
          scope.assignedUserId       = undefined;
          scope.reassignmentFeedback = undefined;

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
          if (userCanWork(selectedDate, assignedUserId)) {
            selectedDate.assignment.$update({user_id: assignedUserId});
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
  }])
