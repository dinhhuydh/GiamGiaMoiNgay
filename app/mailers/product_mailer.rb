class ProductMailer < ActionMailer::Base
  default from: "admin@giamgiamoingay.com"

  def price_descreased(product)
    @product = product
    product.followers.each do |user|
      mail( to: user.email,
            subject: t('product.price_descreased', locale: I18n.default_locale,
                                                    product_name: product.name,
                                                    product_price: product.price))
    end
  end

  def already_sold(product)
    @product = product
    product.followers.each do |user|
      mail( to: user.email,
            subject: t('product.already_sold', locale: I18n.default_locale,
                                                product_name: product.name,
                                                product_price: product.price))
    end
  end
end
