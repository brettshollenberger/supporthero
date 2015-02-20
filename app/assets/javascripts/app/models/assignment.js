angular
  .module('supporthero')
  .factory('Assignment', ['Createable', 'User', function(Createable, User) {

    Createable(Assignment);

    function Assignment(params) {
      this.id           = params.id;
      this.user         = User.new(params.user);

      this.$update = function(params) {
        var subject = new Rx.Subject();

        this.update(params);

        $.ajaxAsObservable({
          method: "PUT",
          url: "api/v1/assignments/" + this.id,
          data: params
        })
        .map(function(response) {
          return response.data;
        })
        .subscribe(function(assignment) {
          subject.onNext(assignment);
        });

        return subject;
      }

      this.update = function(params) {
        for (var key in params) {
          if (key == "user_id") {
            this.user = User.cached.find(params[key]);
          } else {
            this[key] = params[key];
          }
        }
      }
    }

    Assignment.$create = function(params) {
      var subject = new Rx.Subject();

      $.ajaxAsObservable({
        method: "POST",
        url: "api/v1/assignments",
        data: params
      })
      .map(function(response) {
        return response.data;
      })
      .subscribe(function(e) {
        var instance = Assignment.new(e);
        subject.onNext(instance);
      });

      return subject;
    }

    return Assignment;

  }]);
