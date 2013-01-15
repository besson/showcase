class MovieController < ApplicationController

  def index
  end

  def check
    @user_id = params[:user_id]

    @known_items = Array.new
    @recommended_items = Array.new

    user_items = UserItem.find(:all, :conditions => ["user_id = ?", @user_id])
    fill_items user_items, @known_items

    rec_items = RecommendedItem.find(:all, :conditions => ["user_id = ?", @user_id], :order => '"order" ASC')
    fill_items rec_items, @recommended_items

  end

  def fill_items raw_items, complete_items
    raw_items.each do |entry|
      item = Item.find(:first, :conditions => ["item_id = ?", entry.item_id])
      if item != nil then
        if item.category.nil? then
          item.category = get_genre item.title, item.extra_info
          item.save
        end
        item.category = item.category.downcase
        complete_items << item
      end
    end
  end

    def get_genre title, year
      response = RestClient.get "http://www.omdbapi.com", {:params => {:t => title, :y => year}}
      data = JSON.parse(response)
      category = data["Genre"]

      if category.nil?
        category = ""
      end

      category.downcase
    end

  end
