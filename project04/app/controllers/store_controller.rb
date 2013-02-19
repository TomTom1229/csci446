class StoreController < ApplicationController
  def index
    @products = Product.paginate :page => params[:page], :per_page => 10, :order => 'title asc'
    @cart = current_cart
  end
end
