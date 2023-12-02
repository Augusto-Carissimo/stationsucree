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

ActiveRecord::Schema[7.0].define(version: 2023_11_30_200241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredient_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity_recipe", default: "0.0"
    t.index ["ingredient_id"], name: "index_ingredient_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredient_recipes_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name_ingredient"
    t.decimal "last_price", precision: 8, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity_ingredient", precision: 8, scale: 3, default: "0.0"
    t.string "unit"
    t.decimal "quantity_per_unit", precision: 8, scale: 3
    t.index ["name_ingredient"], name: "index_ingredients_on_name_ingredient", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name_location"
    t.string "address"
    t.integer "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_location"], name: "index_locations_on_name_location", unique: true
  end

  create_table "price_histories", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_price_histories_on_ingredient_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name_product"
    t.integer "quantity_product", default: 0
    t.string "recipe_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_subproduct", default: false
    t.index ["name_product"], name: "index_products_on_name_product", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_recipes_on_product_id", unique: true
  end

  create_table "stock_per_locations", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity_stock", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_stock_per_locations_on_location_id"
    t.index ["product_id"], name: "index_stock_per_locations_on_product_id"
  end

  create_table "subproduct_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "product_id", null: false
    t.float "quantity_recipe", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_subproduct_recipes_on_product_id"
    t.index ["recipe_id"], name: "index_subproduct_recipes_on_recipe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ingredient_recipes", "ingredients"
  add_foreign_key "ingredient_recipes", "recipes"
  add_foreign_key "price_histories", "ingredients"
  add_foreign_key "recipes", "products"
  add_foreign_key "stock_per_locations", "locations"
  add_foreign_key "stock_per_locations", "products"
  add_foreign_key "subproduct_recipes", "products"
  add_foreign_key "subproduct_recipes", "recipes"
end
