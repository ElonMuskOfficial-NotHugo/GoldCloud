class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true

  # package instance methods
  delegate :add_product, :remove_product, :product_quantity, to: :itemable, allow_nil: true

  scope :products, -> { where(itemable_type: 'Product') }
  scope :packages, -> { where(itemable_type: 'Package') }

  def primary_photo_url
    itemable.primary_photo_url
  end

  def self.search(query)
    itemable_types = ['Product', 'Package']  # Add more types here as needed

    conditions = itemable_types.map do |type|
      klass = type.constantize
      searchable_columns = klass.column_names & ['name', 'description']
      searchable_columns.map { |col| "#{type.tableize}.#{col} ILIKE :query" }.join(' OR ')
    end.join(' OR ')

    joins_clause = itemable_types.map do |type|
      "LEFT JOIN #{type.tableize} ON items.itemable_type = '#{type}' AND items.itemable_id = #{type.tableize}.id"
    end.join(' ')

    joins(joins_clause).where(conditions, query: "%#{query}%")
  end
end
