class ProductController < ApplicationController

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
      complete_items << item
    end
  end

end
