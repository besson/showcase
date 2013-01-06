class AnalyzerController < ApplicationController

  def index
  end

  def check
    @user_id = params[:user_id]

    client = RestClient.new
    @buyed_items = Array.new
    @recommended_items = Array.new

    user_items = UserItem.find(@user_id)
    fill_items user_items, @buyed_items

    rec_items = RecommendedItem.find(@user_id, :order => "order")
    fill_items rec_items, @recommended_items
  end

  def fill_items raw_items, complete_items
    raw_items.each do |entry|
      item = Item.find(entry.item_id)
      if item.category.empty?
        item.category = client.get_genre item.title item.year
        item.save
      end
      complete_items.add item
    end
  end

end
