angular
  .module('supporthero')
  .directive('notifications', ['Event', 'User', function(Event, User) {
    return {
      scope: {},
      templateUrl: "views/directives/notifications.html",
      link: function(scope, element, attrs) {
        scope.events = [];

        User
          .current_user()
          .subscribe(function() {
            Event
              .forCurrentUser()
              .subscribe(function(e) {
                scope.events.push(e);
              });
          });
        }
    }
  }]);
