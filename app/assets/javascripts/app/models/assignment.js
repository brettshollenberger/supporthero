angular
  .module('supporthero')
  .factory('Assignment', ['Createable', 'User', function(Createable, User) {

    Createable(Assignment);

    function Assignment(params) {
      this.id   = params.id;
      this.user = User.new(params.user);

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

    return Assignment;

  }]);
