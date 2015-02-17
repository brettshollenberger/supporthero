angular
  .module('supporthero')
  .factory('Availability', ['Createable', 'User', function(Createable, User) {

    Createable(Availability);

    function Availability(params) {
      for (var key in params) {
        this[key] = params[key];
      }

      this.user = User.new(params.user);
    }

    return Availability;

  }]);
