module ProductsHelper
  def product_image(product, style = 'medium')
    if product.images.present?
      image_tag product.images.first.photo.url(style.to_sym)
    else
      image_tag image_path('default_product_image.jpg')
    end
  end
end
