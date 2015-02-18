angular
  .module('supporthero')
  .directive('selectedDate', ['User', function(User) {
    return {
      templateUrl: "views/directives/selected_date.html",
      link: function(scope, element, attrs) {
      }
    }
  }]);
