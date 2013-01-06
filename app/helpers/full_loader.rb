class FullLoader

  def load
    # user_items = UserItemsLoader.new
    # user_items.load

    items = ItemsLoader.new
    items.load

    rec_items = RecommendedItemsLoader.new
    rec_items.load
  end
end
