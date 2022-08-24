class MenuItemDenormalizer
  attr_reader :menu_item

  def initialize(menu_item)
    @menu_item = menu_item
  end

  def to_hash
    %w[id
       name
       price
       description
       menu_category]
      .map { |method_name| [method_name, send(method_name)] }.to_h
  end

  def id
    menu_item.id
  end

  def name
    menu_item.name
  end

  def price
    menu_item.price
  end

  def description
    menu_item.description
  end

  def menu_category_id
    menu_item.menu_category_id
  end

  def menu_category
    { id: menu_item.menu_category.id, name: menu_item.menu_category.name }
  end
end
