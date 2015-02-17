angular
  .module('supporthero')
  .factory('User', ['Cache', function(Cache) {

    function User(options) {}

    User.cached = new Cache();

    User.current_user = function() {
      var subject = new Rx.Subject();

      if (_.isUndefined(User.cached["current_user"])) {
        $.ajaxAsObservable({
          url: "api/v1/users/me"
        })
        .map(function(response) {
          return response.data;
        })
        .subscribe(function(user) {
          User.cached.cache(user);
          User.cached["current_user"] = user;

          subject.onNext(user);
        });
      }

      return subject;
    }

    return User;

  }]);
