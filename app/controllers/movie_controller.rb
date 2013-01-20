class MovieController < ApplicationController

  def index
  end

  def check
    @user_id = params[:user_id]

    @known_items = Array.new
    @recommended_items = Array.new
    @recommended_items_solr = Array.new

    user_items = UserItem.find(:all, :conditions => ["user_id = ?", @user_id])
    fill_items user_items, @known_items

    rec_items = RecommendedItem.find(:all, :conditions => ["user_id = ?", @user_id], :order => '"order" ASC')
    fill_items rec_items, @recommended_items

    rec_items_solr = get_solr_recommendation @user_id, @known_items
    fill_items rec_items_solr, @recommended_items_solr

  end

  def fill_items raw_items, complete_items
    raw_items.each do |entry|
      item = Item.find(:first, :conditions => ["item_id = ?", entry.item_id])
      if item != nil then
        if item.category.empty? then
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

  def get_solr_recommendation user_id, known_items
    solr_user_url = "http://localhost:8983/solr/user-item/select"

    discover_query = "id:("
    recommend_query = "user_ids:("
    items = Array.new

    known_items.each do |item|
      discover_query += "#{item.id} OR "
    end

    discover_query.chomp! " OR "
    discover_query += ")"

    response = RestClient.get solr_user_url, {:params => {:q => discover_query, :wt => "json", :facet => true, :"facet.field" => "user_ids"}}
    data = JSON.parse(response)

    facets = data["facet_counts"]["facet_fields"]["user_ids"]

    facets.each_slice(2) do |slice|
      if slice[0] != user_id
        recommend_query += "#{slice[0]}^#{slice[1]} OR "
      end
    end

    recommend_query.chomp! " OR "
    recommend_query += " AND -#{user_id})"

    items_id = Array.new
    response = RestClient.get solr_user_url, {:params => {:q => recommend_query, :wt => "json"}}

    data = JSON.parse(response)
    data["response"]["docs"].each do |entry| 
      items_id << entry["id"]
    end

    items_id.each do |i|
      item = Item.find(:first, :conditions => ["item_id = ?", i])
      if item != nil then
        items << item
      end
    end

    items
  end

end
