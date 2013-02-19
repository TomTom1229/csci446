Product.transaction do
    (1..50).each do |i|
        Product.create(title: "#{i}", description: "#{i}", image_url: "#{i}.png", price: 0.01)
    end
end