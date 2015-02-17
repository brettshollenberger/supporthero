angular
  .module("supporthero")
  .filter("month", ['Month', function(Month) {
    return function(monthIndex) {
      return Month.names[monthIndex-1];
    }
  }]);
