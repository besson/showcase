
class MovieController < ApplicationController
  require "open_imdb_client"

  def initialize()
    @client = ::OpenIMDbClient.new
  end

  def index
  end

  def check
    @user_id = params[:user_id]

    @known_items = Array.new
    @recommended_items = Array.new

    user_items = UserItem.find(:all, :conditions => ["user_id = ?", @user_id])
    fill_items user_items, @known_items

    rec_items = RecommendedItem.find(:all, :conditions => ["user_id = ?", @user_id], :order => "`order` ASC")
    fill_items rec_items, @recommended_items

  end

  def fill_items raw_items, complete_items
    raw_items.each do |entry|
      item = Item.find(:first, :conditions => ["item_id = ?", entry.item_id])
      if item.category.nil?
        item.category = @client.get_genres(item.title, item.extra_info)
        item.save
      end

      complete_items << item
    end
  end

end
