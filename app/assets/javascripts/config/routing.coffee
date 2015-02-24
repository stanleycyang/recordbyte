class config
  constructor: ($stateProvider, $urlRouterProvider)->
    # For unmatched URLs
    $urlRouterProvider.otherwise '/'

    # States
    $stateProvider
      .state 'Home',
          url: '/'
          title: 'Recordbyte'
          templateUrl: 'home.html'
          controller: 'MainController'
          controllerAs: 'main'



angular
  .module 'app'
  .config config
