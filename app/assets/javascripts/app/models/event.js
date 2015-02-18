angular
  .module('supporthero')
  .factory('Event', ['Createable', 'User', 'Assignment', 'CalendarDate', '$rootScope', 
  function(Createable, User, Assignment, CalendarDate, $rootScope) {

    Createable(Event);

    function Event(params) {
      for (var key in params) {
        this[key] = params[key];
      }

      this.creator = User.new(params.creator);
      
      if (this.eventable.type == "Assignment") {
        this.eventable = Assignment.new(this.eventable);
      }

      this.calendar_date = CalendarDate.new(this.calendar_date);

      this.$delete = function() {
        var subject = new Rx.Subject();

        Event.cached.removeCached(this);

        $.ajaxAsObservable({
          method: "DELETE",
          url: "api/v1/events/" + this.id
        })
        .subscribe(function(response) {
          subject.onNext(response);
        });

        return subject;
      }
    }

    Event.forCurrentUser = function() {
      var subject = new Rx.Subject();

      $.ajaxAsObservable({
        url: "api/v1/events",
        data: {recipient_id: User.cached["current_user"].id}
      })
      .flatMap(function(response) {
        return response.data;
      })
      .subscribe(function(e) {
        var instance = Event.new(e);
        subject.onNext(instance);
        $rootScope.$apply();
      });

      return subject;
    }

    Event.$create = function(params) {
      var subject = new Rx.Subject();

      $.ajaxAsObservable({
        method: "POST",
        url: "api/v1/events",
        data: params
      })
      .map(function(response) {
        return response.data;
      })
      .subscribe(function(e) {
        var instance = Event.new(e);
        subject.onNext(instance);
      });

      return subject;
    }

    return Event;

  }]);
