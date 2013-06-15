@ProductsCtrl = ['$scope', '$http', ($scope, $http) ->
  $scope.productId = $('#product').data('product-id')
  $scope.followersCount = $('#product').data('followers-count')
  $scope.followDisable = $('#follow').hasClass('disabled')

  $scope.follow = () ->
    return if $scope.followDisable

    confirmed = confirm('Bạn sẽ nhận được thông báo khi sản phẩm này thay đổi')
    if confirmed
      followProduct($scope.productId)

  followProduct = (productId) ->
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
]


