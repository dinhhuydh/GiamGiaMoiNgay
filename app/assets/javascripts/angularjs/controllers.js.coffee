@ProductsCtrl = ['$scope', '$http', ($scope, $http) ->
  $scope.productId = $('#product').data('product-id')
  $scope.followersCount = $('#product').data('followers-count')
  $scope.followDisable = $('#follow').hasClass('disabled')
  $scope.buyDisable = $('#buy').hasClass('disabled')

  $scope.follow = () ->
    return if $scope.followDisable

    confirmed = confirm('Bạn sẽ nhận được thông báo khi sản phẩm này thay đổi')
    if confirmed
      _followProduct($scope.productId)

  $scope.buy = () ->
    return if $scope.buyDisbale

    confirmed = confirm('You order this product?')
    if confirmed
      _buyProduct($scope.productId)

  _followProduct = (productId) ->
    $http.get(productId + '/follow')
         .success((data) ->
           $scope.followersCount = data.followersCount
           $('#follow').addClass('disabled')
           $('#follow').removeClass('btn-primary')
           alert('Bạn đã theo dõi sản phẩm này')
         )
         .error((data) ->
           alert('There is something wrong. Please try again')
         )

  _buyProduct = (productId) ->
    $http.get(productId + '/buy')
         .success((data) ->
           $scope.ordersCount = data.ordersCount
           $('#buy').addClass('disabled')
           $('#buy').removeClass('btn-primary')
           if $scope.ordersCount == 1
             alert('Congratulations! You are the first')
           else
             alert("There are #{$scope.ordersCount} people ordered it. Would you like to wait?")
         )
         .error((data) ->
           alert('There is something wrong. Please try again')
         )
]
