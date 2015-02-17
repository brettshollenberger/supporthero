angular
  .module("supporthero")
  .filter("username", ['User', function(User) {
    return function(user) {
      if (!_.isUndefined(user)) {
        if (User.cached["current_user"] == user) {
          return "You";
        } else {
          return user.fullName();
        }
      }
    }
  }]);
