class AdminController < ApplicationController
  def index
    redirect_to products_url
  end
end
