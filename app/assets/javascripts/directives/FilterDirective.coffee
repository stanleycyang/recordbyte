filter = ->
  directive =
    restrict: 'E'
    templateUrl: 'filter.html'

angular
  .module 'app'
  .directive 'filter', filter
