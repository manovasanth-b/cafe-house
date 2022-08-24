class MenuItem < ActiveRecord::Base
  belongs_to :menu_category, class_name: "MenuCategory", foreign_key: :menu_category_id
  has_many :order_items, class_name: "OrderItem", :dependent => :destroy
  validates :menu_category, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(_options = {})
    MenuItemDenormalizer.new(self).to_hash
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :id, type: :integer
      indexes :name, type: :text
      indexes :menu_category_id, type: :integer
      indexes :price, type: :half_float
      indexes :description, type: :text
      indexes :menu_category, type: :nested do
        indexes :id, type: :integer
        indexes :name, type: :text
      end
    end
  end
end
