class CreateSchemas < ActiveRecord::Migration[7.0]
  def change
    create_table :schemas do |t|
      t.boolean :root_node, default: false, null: false
      t.integer :status, default: 0, null: false

      t.string  :field_name
      t.text    :description
      t.string  :required_fields
      t.string  :default_value
      t.string  :minimum_value
      t.string  :maximum_value
      t.json    :metadata, default: {}, null: false
      t.integer :schema_type, default: 0, null: false
      t.jsonb   :schema, default: {}, null: false

      t.string :ancestry, index: true

      t.timestamps
    end
  end
end
