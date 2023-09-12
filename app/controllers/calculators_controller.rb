class CalculatorsController < ApplicationController

  def index
    @products = Product.where(is_subproduct: false).joins(:recipe)
  end

  def create
    @products = Product.where(is_subproduct: false).joins(:recipe)
    production = {}
    price = 0.0
    params[:calculator].each do |param|
      product_recipe = Product.find(param[0]).recipe
      price += product_recipe.total_price * param[1].to_f
      amount_x_quantity_to_produce = product_recipe.total_amount.transform_values { |v| v * param[1].to_f }
      production = production.merge(amount_x_quantity_to_produce) { |_,o,n| (o + n).round(2) }
    end
    @production_cache = ActiveSupport::Cache::MemoryStore.new
    @production_cache.write('production', production)
    @production_cache.write('price', price.round(2))
    render 'index'
  end
end
