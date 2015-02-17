angular
  .module('supporthero')
  .factory('Year', ['Month', function(Month) {

    function Year(params) {
      var year = this;

      year.calendarDates = [];
      year.months        = {};

      _.each(_.range(1, 13), function(month) { year.months[month] = new Month(); });

      year.load = function() {
        var loadSubject = new Rx.Subject();

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
          loadSubject.onNext(year);
        });

        return loadSubject;
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
    
    return Year;

  }]);
