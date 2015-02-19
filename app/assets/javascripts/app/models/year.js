angular
  .module('supporthero')
  .factory('Year', ['Month', 'CalendarDate', function(Month, CalendarDate) {

    function Year(params) {
      var year = this;

      year.calendarDates = [];
      year.months        = {};

      _.each(_.range(1, 13), function(month) { year.months[month] = new Month(); });

      year.load = function(years) {
        var loadSubject = new Rx.Subject();

        $.ajaxAsObservable({ 
          url: "api/v1/calendar_dates.json",
          data: {
            year: params.year
          }
        })
        .flatMap(function(response) {
          return response.data;
        })
        .map(function(calendarDate) {
          return CalendarDate.new(calendarDate);
        })
        .subscribe(function(calendarDate) {
          year.calendarDates.push(calendarDate);
        }, function(error) {
          console.log(error);
        }, function() {
          year.splitMonths(years);
          loadSubject.onNext(year);
        });

        return loadSubject;
      }

      year.splitMonths = function(years) {
        var months = _.groupBy(year.calendarDates, function(calendarDate) {
          return calendarDate.month;
        });

        var prevDecember, nextJanuary;

        if (years[params.year-1]) {
          prevDecember = _.select(years[params.year-1].months[12].dates, function(date) { 
            return date.constructor.name == "CalendarDate" && date.month == 12; 
          })
        }

        if (years[params.year+1]) {
          nextJanuary = _.select(years[params.year+1].months[1].dates, function(date) { 
            return date.constructor.name == "CalendarDate" && date.month == 1; 
          })
        }

        _.each(_.keys(months), function(i) {
          i = parseFloat(i);

          var month = year.months[i];

          month.previousMonth = months[i-1] || prevDecember;
          month.currentMonth  = months[i];
          month.nextMonth     = months[i+1] || nextJanuary;

          month.addDates();
        });

        year.joinAdjacent(years);
      }

      year.joinAdjacent = function(years) {
        _.each(_.keys(years), function(year) {
          year = parseFloat(year);

          var unjoinedJanuary = !!_.select(years[year].months[1].dates, function(date) {
            return date.constructor.name != "CalendarDate";
          });

          var unjoinedDecember = !!_.select(years[year].months[1].dates, function(date) {
            return date.constructor.name != "CalendarDate";
          });

          if (unjoinedJanuary && years[year-1]) {
            var prevDecember = _.select(years[year-1].months[12].dates, function(date) { 
              return date.constructor.name == "CalendarDate" && date.month == 12; 
            });

            years[year].months[1].previousMonth = prevDecember;
            years[year].months[1].addDates();
          }

          if (unjoinedDecember && years[year+1]) {
            var nextJanuary = _.select(years[year+1].months[1].dates, function(date) { 
              return date.constructor.name == "CalendarDate" && date.month == 1; 
            });

            years[year].months[12].nextMonth = nextJanuary;
            years[year].months[12].addDates();
          }
        });
      }
    }
    
    return Year;

  }]);
