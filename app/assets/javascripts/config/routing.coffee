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
          templateUrl: 'profile.html'
          controller: 'UsersController'
          controllerAs: 'user'
      .state 'settings',
          url: '/settings'
          title: 'Edit user'
          templateUrl: 'settings.html'
          controller: 'UsersController'
          controllerAs: 'user'
      .state 'post',
          url: '/post'
          title: 'Create a book review'
          templateUrl: 'post.html'
          controller: 'PostsController'
          controllerAs: 'post'

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
