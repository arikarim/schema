class Schema < ApplicationRecord
  has_ancestry

  enum status: { active: 0, inactive: 1 }
  enum schema_type: { string: 0, number: 1, float: 2, boolean: 3, array: 4, object: 5 }
  validates :field_name, presence: true, unless: proc { |a| a.root_node }

  # Root node callbacks
  before_save :set_json_schema_attributes, if: proc { |schema| schema.root_node? }
  # General schema callbacks
  before_save :set_required_fields, if: proc { |schema| schema.required_fields.present? }

  # None root node callbacks
  before_save :set_basic_schema_attributes, unless: proc { |schema| schema.root_node? }

  def set_json_schema_attributes
    schema['$id'] = 'https://example.com/person.schema.json'
    schema['$schema'] = 'http://json-schema.org/draft-07/schema#'
    schema['title'] = 'Schema generation'
    schema['type'] = 'object'
    schema['properties'] = {}
  end

  def set_required_fields
    schema['required'] = required_fields.split(',')
  end

  def set_basic_schema_attributes
    schema['type'] = schema_type
    schema['title'] = field_name
    schema['description'] = description
    schema['default'] = default_value if default_value.present?
    schema['minimum'] = minimum_value if minimum_value.present?
    schema['maximum'] = maximum_value if maximum_value.present?
    schema['__metadata'] = metadata if metadata.present?
    schema['properties'] = {} if schema_type == 'object'
    # schema['enum'] = enum_values if enum_values.present?
    # schema['format'] = format if format.present?
    # schema['items'] = items if items.present?
    # schema['properties'] = properties if properties.present?
  end
end
