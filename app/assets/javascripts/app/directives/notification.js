angular
  .module('supporthero')
  .directive('notification', [function() {
    return {
      templateUrl: 'views/directives/notification.html',
      link: function(scope, element, attrs) {
        scope.src = "views/directives/" + scope.notification.event_type.split(" ").join("_");
      }
    }
  }]);
