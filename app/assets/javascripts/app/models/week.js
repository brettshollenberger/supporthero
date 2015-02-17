angular
  .module('supporthero')
  .factory('Week', [function() {

    function Week(options) {
      this.dates = options.dates;
    }

    Week.days = [
      "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ];

    return Week;

  }]);
