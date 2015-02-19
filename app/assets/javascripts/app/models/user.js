angular
  .module('supporthero')
  .factory('User', ['Createable', function(Createable) {

    var admin = false;

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
          return User.new(response.data);
        })
        .subscribe(function(user) {
          admin = user.admin;

          User.cached["current_user"] = user;

          subject.onNext(user);
        });
      } else {
        setTimeout(function() {
          subject.onNext(User.cached["current_user"]);
        }, 1);
      }

      return subject;
    }

    User.all = function() {
      var subject = new Rx.Subject();

      $.ajaxAsObservable({
        url: "api/v1/users"
      })
      .map(function(response) {
        return User.new(response.data);
      })
      .subscribe(function(users) {
        subject.onNext(users);
      });

      return subject;
    }

    User.currentUserIsAdmin = function() {
      return admin;
    }

    return User;

  }]);
