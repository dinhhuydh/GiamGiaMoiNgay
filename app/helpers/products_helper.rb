module ProductsHelper
  def product_image(product, style = 'medium')
    if product.images.present?
      image_tag product.images.first.photo.url(style.to_sym)
    else
      image_tag image_path('default_product_image.jpg')
    end
  end

  def humanize_vnd_price(price)
    number_to_currency(price, locale: I18n.default_locale,
                              precision: 0,
                              unit: t('vnd_symbol'),
                              format: '%n %u',
                              delimiter: '.')
  end
end
