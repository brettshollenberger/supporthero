angular
  .module('supporthero')
  .factory('User', ['Createable', function(Createable) {

    Createable(User);

    function User(params) {
      for (var key in params) {
        this[key] = params[key];
      }

      this.fullName = function() {
        return this.first_name + " " + this.last_name;
      }
    }

    User.current_user = function() {
      var subject = new Rx.Subject();

      if (_.isUndefined(User.cached["current_user"])) {
        $.ajaxAsObservable({
          url: "api/v1/users/me"
        })
        .map(function(response) {
          return new User(response.data);
        })
        .subscribe(function(user) {
          User.cached.cache(user);
          User.cached["current_user"] = user;

          subject.onNext(user);
        });
      } else {
        subject.onNext(user);
      }

      return subject;
    }

    return User;

  }]);
