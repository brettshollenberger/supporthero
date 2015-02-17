angular
  .module('supporthero')
  .factory('CalendarDate', ['Createable', 'Assignment', 'Availability', 
  function(Createable, Assignment, Availability) {

    Createable(CalendarDate);

    function CalendarDate(params) {
      for (var key in params) {
        this[key] = params[key];
      }

      if (!_.isUndefined(params.assignment)) {
        this.assignment = Assignment.new(params.assignment);
      }

      if (!_.isUndefined(params.availabilities)) {
        this.availabilities = _.map(params.availabilities, function(availability) {
          return Availability.new(availability);
        });
      }

      this.weekend = function() {
        return _.include(["Saturday", "Sunday"], this.day_of_week);
      }

      this.needsAssignment = function() {
        return this.assignable && this.upcoming && _.isUndefined(this.assignment);
      }
    }

    return CalendarDate;

  }]);
