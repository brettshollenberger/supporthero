angular
  .module('supporthero')
  .factory('Availability', ['Createable', 'User', function(Createable, User) {

    Createable(Availability);

    function Availability(params) {
      for (var key in params) {
        this[key] = params[key];
      }

      this.user = User.new(params.user);

      this.$delete = function() {
        var subject = new Rx.Subject();

        Availability.cached.removeCached(this);

        $.ajaxAsObservable({
          method: "DELETE",
          url: "api/v1/availabilities/" + this.id
        })
        .subscribe(function(response) {
          subject.onNext(response);
        });

        return subject;
      }
    }

    return Availability;

  }]);
