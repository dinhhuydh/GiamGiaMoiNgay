module ProductsHelper
  def product_image(product)
    if product.images.present?
      image_tag product.images.first.photo.url
    else
      image_tag image_path('default_product_image.jpg')
    end
  end
end
