class UserItemsLoader

  def load
    file_path = Rails.root.join("data","qualifying-clean.txt").to_s
    file = File.open(file_path)

    file.each_line do |line|
      line_fields = line.split(",")

      user_item = UserItem.new
      user_item.user_id = line_fields[0]
      user_item.item_id = line_fields[1]
      user_item.save
    end

    file.close
  end

end