angular
  .module('supporthero')
  .factory('Calendar', ['Year', function(Year) {

    function Calendar() {
      this.years = {};

      this.loadYear = function(year) {
        if (_.isUndefined(this.years[year])) {
          this.years[year] = new Year({year: year});
          return this.years[year].load(this.years);
        }
      }
    }

    return Calendar;
  }]);
