angular
  .module('supporthero')
  .controller('CalendarCtrl', ['$scope', 'User', function($scope, User) {

    User
    .current_user()
    .subscribe(function(user) {
      $scope.currentUser = user;
    });

    User.all()

  }]);
