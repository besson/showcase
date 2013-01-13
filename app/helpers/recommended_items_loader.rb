class RecommendedItemsLoader

  def load
    file_path = Rails.root.join("data","netflix", "results.txt").to_s
    file = File.open(file_path)

    file.each_line do |line|
      line_fields = line.gsub(":1.0","").gsub("]","").split("[")
      items = line_fields[1].split(",")

      items.each_with_index do |item, i|
        rec_item = RecommendedItem.new
        rec_item.user_id = line_fields[0]
        rec_item.item_id = item
        rec_item.order = i
        rec_item.save
      end
    end

    file.close
  end

end


