class config
  constructor: ($stateProvider, $urlRouterProvider)->
    # For unmatched URLs
    $urlRouterProvider.otherwise '/'

    # States
    $stateProvider
      .state 'home',
          url: '/'
          title: 'Recordbyte'
          templateUrl: 'home.html'
      .state 'profile',
          url: '/users/:id'
          title: 'Profile'
          templateUrl: 'profile.html'

# When the state changes, change the title
class run
  constructor:($rootScope, $state)->

    changeRoute = (event, current, previous) ->
      $rootScope.title = $state.current.title

    $rootScope.$on '$stateChangeSuccess', changeRoute

angular
  .module 'app'
  .config config
  .run run
