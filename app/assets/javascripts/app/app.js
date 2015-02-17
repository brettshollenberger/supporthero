angular
  .module('supporthero', ['ng', 'ngRoute', 'ngAnimate'])

  .config(function ($routeProvider) {

    $routeProvider

      .when('/', {
        templateUrl: 'views/calendar.html',
        controller: 'CalendarCtrl'
      })

      .otherwise({
        redirectTo: '/'
      });

  });

function privateVariable(object, name, value) {
  var val;
  Object.defineProperty(object, name, {
    enumerable: false,
    configurable: true,
    get: function()       { return val; },
    set: function(newval) { val = newval; }
  });

  if (value !== undefined) object[name] = value;
};
