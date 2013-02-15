require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product_with_image(image_url)
    return Product.new(title: "y", description: "yy", image_url: image_url, price: 0.01)
  end

  def new_product_with_name(name)
    return Product.new(title: name, description: "yy", image_url: "url.png", price: 0.01)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price must be positive" do
    product = Product.new(title: "y", description: "yy", image_url: "image.jpg")

    product.price = -1
    assert product.invalid?

    product.price = 0
    assert product.invalid?

    product.price = 1
    assert product.valid?
  end

  test "image url" do 
    good = %w(fred.png FRED.png fred.PNG fReD.pNg sdfansuvinwervevneauivn://;;;/;;.png)

    bad = %w( fred.doc fred.png/ fred )

    good.each do |file|
      assert new_product_with_image(file).valid?
    end

    bad.each do |file|
      assert new_product_with_image(file).invalid?
    end
  end

  test "product if not valid without a unique title" do
    product = new_product_with_name(products(:ruby).title)

    assert product.invalid?
  end
end
