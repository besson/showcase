class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :item_id
      t.string :title
      t.string :extra_info
      t.timestamps
    end
  end
end
