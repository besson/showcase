#clean training set for mahout

class Processor

  def read_file
    puts "Reading...."
    count = 0;
    file = File.open "qualifying.txt", "r"
    @new_content = ""

    file.each_line do |line|
      count = count + 1
      puts count
      if line.include? ":"
        @movie_id = line.split(":")[0]
      else
        user_id = line.split(",")[0]
        @new_content += user_id + "," + @movie_id + "\n"
      end
    end
  end

  def write_file
    puts "Writing..."
    file = File.open "qualifying-clean.txt", "w"
    file.write(@new_content)
    file.close 
  end

end

processor = Processor.new
processor.read_file
processor.write_file
