angular
  .module('supporthero')
  .directive('acceptRequest', ['User', function(User) {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope
            .notification
            .eventable
            .$update({user_id: User.cached["current_user"].id})

          scope.notification.$delete()

          scope.removeNotification(scope.notification);

          scope.$apply();
        });
      }
    }
  }]);
