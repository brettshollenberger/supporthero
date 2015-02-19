angular
  .module('supporthero')
  .directive('editDate', ['User', function(User) {
    return {
      templateUrl: "views/directives/edit_date.html",
      link: function(scope, element, attrs) {
      }
    }
  }]);
