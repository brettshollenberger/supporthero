angular
  .module("supporthero")
  .filter("date", ['Month', function(Month) {
    return function(calendarDate) {
      if (!_.isUndefined(calendarDate)) {
        return calendarDate.day_of_week + ", " + Month.names[calendarDate.month-1] + " " + calendarDate.day + ", " + calendarDate.year;
      }
    }
  }]);
