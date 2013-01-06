class ItemsLoader

  def load
    file_path = Rails.root.join("data","movie_titles.txt").to_s
    file = File.open(file_path)

    file.each_line do |line|
      line_fields = line.split(",")

      item = Item.new
      item.item_id = line_fields[0]
      item.extra_info = line_fields[1]
      item.title = line_fields[2]
      item.save
    end

    file.close
  end

end

