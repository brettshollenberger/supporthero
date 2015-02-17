angular
  .module('supporthero')
  .factory('Assignment', ['Createable', 'User', function(Createable, User) {

    Createable(Assignment);

    function Assignment(params) {
      this.id   = params.id;
      this.user = User.new(params.user);
    }

    return Assignment;

  }]);
