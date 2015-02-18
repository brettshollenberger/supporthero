angular
  .module('supporthero')
  .directive('notifications', ['Event', 'User', function(Event, User) {
    return {
      scope: {},
      templateUrl: "views/directives/notifications.html",
      link: function(scope, element, attrs) {
        scope.notifications = [];

        scope.removeNotification = function(notification) {
          var index = scope.notifications.indexOf(notification);

          if (index > -1) {
            scope.notifications.splice(index, 1);
          }
        }

        User
          .current_user()
          .subscribe(function() {
            Event
              .forCurrentUser()
              .subscribe(function(e) {
                scope.notifications.push(e);
              });
          });
        }
    }
  }]);
