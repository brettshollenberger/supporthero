angular
  .module('supporthero')
  .factory('Createable', ['Cache', function(Cache) {

    function Createable(klass) {
      klass.cached = new Cache();

      klass.new = function(params) {
        if (params.id && klass.cached[params.id]) {
          return klass.cached[params.id];
        } else {
          var instance = new klass(params);
          klass.cached.cache(instance);

          return instance;
        }
      };
    }

    return Createable;

  }]);
