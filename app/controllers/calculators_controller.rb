# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :set_products
  before_action :require_user

  def index; end

  def create # rubocop:disable Metrics/AbcSize: Assignment Branch Condition size for produce_product is too high
    production = {}
    price = 0.0
    params[:calculator].each do |param|
      product_recipe = Product.find(param[0]).recipe
      price += product_recipe.total_price * param[1].to_f
      amount_x_quantity_to_produce = product_recipe.total_amount.transform_values { |v| v * param[1].to_f }
      production = production.merge(amount_x_quantity_to_produce) { |_, o, n| (o + n).round(3) }
    end
    production_cache(production, price)
    render 'index'
  end

  private

  def production_cache(production, price)
    @production_cache = ActiveSupport::Cache::MemoryStore.new
    @production_cache.write('production', production)
    @production_cache.write('price', price.round(3))
    @production_cache
  end

  def set_products
    @products = Product.where(is_subproduct: false).joins(:recipe)
  end
end
