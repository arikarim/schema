class SchemasController < ApplicationController
  def index
    @schemas = Schema.all

    render json: @schemas
  end

  def show
    @schema = Schema.find(params[:id])
    render json: @schema
  end

  def create
    @schema = Schema.new(schema_params)
    if @schema.save
      render json: @schema, status: :created, location: @schema
    else
      render json: @schema.errors, status: :unprocessable_entity
    end
  end

  def finalized_schema
    @resource = Schema.find(params[:schema_id])
    @schema = @resource.subtree.arrange_serializable do |node, children|
      schema = node.schema
      objects = children.map { |child| child.try(:[], :schema) } if children.present?
      testt = objects&.each_with_object({}) do |object, hash|
        hash[object['title']] = object
      end
      schema['properties'] = objects if testt.present?
      # debugger
      # obj = {}
      obj[:schema] = schema if schema.present?
      # obj[:children] = children if children.present?

      obj
    end

    render json: @schema
  end

  private

  def schema_params
    params.require(:schema).permit(:root_node, :status, :parent_id, :field_name, :description, :required_fields, :schema_type,
                                   metadata: {})
  end
end
