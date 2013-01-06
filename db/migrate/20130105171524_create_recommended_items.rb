class CreateRecommendedItems < ActiveRecord::Migration
  def change
    create_table :recommended_items do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :order
      t.timestamps
    end
  end
end
