angular
  .module('supporthero')
  .factory('Calendar', ['$rootScope', function($rootScope) {

    function Calendar() {
      this.years = {};

      this.loadYear = function(year) {
        this.years[year] = new Year(year);
        this.years[year].load();
      }
    }

    function Month(options) {
      var startOfWeek    = "Sunday";

      this.dates = [];

      this.addDates = function() {
        var prevMonth = prevMonthDates.call(this),
            nextMonth = nextMonthDates.call(this);

        _.each(_.flatten([prevMonth, this.currentMonth, nextMonth]), function(date) {
          this.dates.push(date);
        }, this);

        $rootScope.$apply();
      }

      function prevMonthDates() {
        var numToDisplay = Week.days.indexOf(this.currentMonth[0].day_of_week);

        if (numToDisplay === 0) {
          return [];
        } else if (!_.isUndefined(this.previousMonth)) {
          return this.previousMonth.slice(-numToDisplay);
        } else {
          return _.map(_.range(numToDisplay), function() {
            return {
              value: "unloaded",
              load: function() {}
            }
          })
        }
      }

      function nextMonthDates() {
        var lastDay      = this.currentMonth[this.currentMonth.length-1].day_of_week,
            numToDisplay = (Week.days.length-1) - Week.days.indexOf(lastDay);

        if (numToDisplay === 0) {
          return [];
        } else if (!_.isUndefined(this.nextMonth)) {
          return this.nextMonth.slice(0, numToDisplay);
        } else {
          return _.map(_.range(numToDisplay), function() {
            return {
              value: "unloaded",
              load: function() {}
            }
          })
        }
      }
    }

    function Week() {}

    Week.days = [
      "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ];

    function Year(params) {
      var year = this;

      year.calendarDates = [];
      year.months        = {};

      _.each(_.range(1, 13), function(month) { year.months[month] = new Month(); });

      year.load = function() {
        $.ajaxAsObservable({ 
          url: "api/v1/calendar_dates.json",
          data: {
            year: params["year"]
          }
        })
        .flatMap(function(response) {
          return response.data;
        })
        .subscribe(function(calendarDate) {
          year.calendarDates.push(calendarDate);
        }, function() {
        }, function() {
          year.splitMonths();
        })
      }

      year.splitMonths = function() {
        var months = _.groupBy(year.calendarDates, function(calendarDate) {
          return calendarDate.month;
        });

        _.each(_.keys(months), function(i) {
          i = parseFloat(i);

          var month = year.months[i];

          month.previousMonth = months[i-1];
          month.currentMonth  = months[i];
          month.nextMonth     = months[i+1];

          month.addDates();
        });
      }
    }

    return Calendar;
  }]);
