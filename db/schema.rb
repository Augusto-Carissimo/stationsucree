# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_12_151657) do
  create_table "ingredient_recipes", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "quantity_recipe", default: 0.0
    t.index ["ingredient_id"], name: "index_ingredient_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredient_recipes_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name_ingredient"
    t.integer "last_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "size", default: 0.0
    t.string "brand"
    t.string "description"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.float "quantity_inventory", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_inventories_on_ingredient_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name_location"
    t.string "address"
    t.integer "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name_product"
    t.integer "quantity_product", default: 0
    t.string "recipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_recipes_on_product_id"
  end

  create_table "stock_per_locations", force: :cascade do |t|
    t.integer "location_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity_stock", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_stock_per_locations_on_location_id"
    t.index ["product_id"], name: "index_stock_per_locations_on_product_id"
  end

  create_table "supplier_ingredients", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "supplier_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_supplier_ingredients_on_ingredient_id"
    t.index ["supplier_id"], name: "index_supplier_ingredients_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingredient_recipes", "ingredients"
  add_foreign_key "ingredient_recipes", "recipes"
  add_foreign_key "inventories", "ingredients"
  add_foreign_key "recipes", "products"
  add_foreign_key "stock_per_locations", "locations"
  add_foreign_key "stock_per_locations", "products"
  add_foreign_key "supplier_ingredients", "ingredients"
  add_foreign_key "supplier_ingredients", "suppliers"
end
