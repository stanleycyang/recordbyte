reviews = ->
  directive =
    restrict: 'E'
    scope:
      review: '=info'
      search: '=filter'
    templateUrl: 'reviews.html'

angular
  .module 'app'
  .directive 'reviews', reviews
