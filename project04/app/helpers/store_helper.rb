module StoreHelper
    def image_or_default(url, extra)
        if(not Rails.application.assets.find_asset(url).nil?)
            image_tag(url, extra)
        else
            extra[:width] = 128
            extra[:height] = 128
            image_tag(image_path("book.ico"), extra)
        end
    end
end
