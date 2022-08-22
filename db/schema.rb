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

ActiveRecord::Schema[7.0].define(version: 2022_08_22_064352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "schemas", force: :cascade do |t|
    t.boolean "root_node", default: false, null: false
    t.integer "status", default: 0, null: false
    t.string "field_name"
    t.text "description"
    t.string "required_fields"
    t.string "default_value"
    t.string "minimum_value"
    t.string "maximum_value"
    t.json "metadata", default: {}, null: false
    t.integer "schema_type", default: 0, null: false
    t.jsonb "schema", default: {}, null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_schemas_on_ancestry"
  end

end
