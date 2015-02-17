angular
  .module('supporthero')
  .factory('Month', ['Week', '$rootScope', function(Week, $rootScope) {

    function Month(options) {
      var startOfWeek = "Sunday";

      this.dates = [];
      this.weeks = [];

      this.lastDay = function() {
        return this.dates.slice(-1)[0];
      }

      this.addDates = function() {
        var prevMonth = prevMonthDates.call(this),
            nextMonth = nextMonthDates.call(this);

        _.each(_.flatten([prevMonth, this.currentMonth, nextMonth]), function(date) {
          this.dates.push(date);
        }, this);

        for (var i = 0; i < this.dates.length-1; i += 7) {
          this.weeks.push(new Week({dates: this.dates.slice(i, i+7)}));
        }

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

    Month.names = [
      "January", "February", "March", "April", "May", "June", "July", "August", "September",
      "October", "November", "December"
    ];

    return Month;

  }]);
