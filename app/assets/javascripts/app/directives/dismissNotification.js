angular
  .module('supporthero')
  .directive('dismissNotification', ['User', function(User) {
    return {
      link: function(scope, element, attrs) {
        element.on("click", function() {
          scope.notification.$delete()
          scope.removeNotification(scope.notification);
          scope.$apply();
        });
      }
    }
  }]);
