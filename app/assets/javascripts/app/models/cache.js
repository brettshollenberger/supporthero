angular
  .module('supporthero')
  .factory('Cache', ['Mixin', 'Functional.Collection', function(Mixin, FunctionalCollection) {

    function Cache() {
      Mixin(this, FunctionalCollection);

      privateVariable(this, 'cache', function(instance) {
        var primaryKey = 'id';
        if (instance && instance[primaryKey] !== undefined) {
          this[instance[primaryKey]] = instance;
        };
      });

      privateVariable(this, 'findCached', function(attributes) {
        return this[attributes[this.primaryKey]];
      });

      privateVariable(this, 'removeCached', function(instance) {
        delete this[instance[this.primaryKey]];
      });

      privateVariable(this, 'find', function(primaryKey) {
        return this[primaryKey];
      });
    };

    return Cache;
  }]);
