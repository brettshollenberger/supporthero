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
