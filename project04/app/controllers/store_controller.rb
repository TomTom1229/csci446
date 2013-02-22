class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    @products = Product.paginate :page => params[:page], :per_page => 10, :order => 'title asc'
    @cart = current_cart
    @line_item = LineItem.new
  end
end
