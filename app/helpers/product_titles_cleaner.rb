class MovieTitlesCleaner

  def clean
    file_path = Rails.root.join("data","products", "items.csv").to_s
    file = File.open(file_path)
    new_content = ""

    file.each_line do |line|
      puts line
      fields = line.split("|")
      new_content += fields[0] + "*" + fields[1]

      size = fields.size - 1
      (2..size).each do |i|
        new_content += "|" + fields[i]
      end
    end

    file.close

    puts "writing .... "
    file_path = Rails.root.join("data", "products").to_s + "/items-clean.csv"
    file = File.open file_path, "w"
    file.write new_content
    file.close
  end

end
