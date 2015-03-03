reviews = ->
  directive =
    restrict: 'E'
    templateUrl: 'reviews.html'

angular
  .module 'app'
  .directive 'reviews', reviews
