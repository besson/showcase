class MovieTitlesCleaner

  def clean
    file_path = Rails.root.join("data","movie_titles.txt").to_s
    file = File.open(file_path)
    new_content = ""

    file.each_line do |line|
      puts line
      fields = line.split(",")
      new_content += fields[0] + "|" + fields[1] + "|" + fields[2]

      size = fields.size - 1
      (3..size).each do |i|
        new_content += "," + fields[i]
      end
    end

    file.close

    puts "writing .... "
    file_path = Rails.root.join("data").to_s + "/movie_titles_clean.csv"
    file = File.open file_path, "w"
    file.write new_content
    file.close
  end

end
