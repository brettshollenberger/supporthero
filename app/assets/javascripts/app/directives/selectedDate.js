angular
  .module('supporthero')
  .directive('selectedDate', [function() {
    return {
      templateUrl: "views/directives/selected_date.html",
      link: function(scope, element, attrs) {
      }
    }
  }]);
