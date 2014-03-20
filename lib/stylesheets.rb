class Stylesheets
  def self.files_paths
    ['main.css']
  end
  
  def self.replace_and_adjust!
    self.replace!
    self.adjust!
  end
  
  def self.replace!
    self.files_paths.each do |file_path|
      puts ">>>>>>> Replacing #{ file_path }"
      
      if File.exists?( self.source_file_path_for(file_path) )
        FileUtils.cp(self.source_file_path_for(file_path), self.destination_file_path_for(file_path))
      end
      if File.exists?( self.destination_file_path_for(file_path) + '.erb' )
        FileUtils.rm(self.destination_file_path_for(file_path) + '.erb')
      end
    end
  end
  
  def self.adjust!
    self.files_paths.each do |file_path|
      puts ">>>>>>> Adjusting #{ file_path }"
      
      file = File.open(destination_file_path_for(file_path), "r")
      content = file.read
      file.close
      
      adjusted_content = content.gsub(/(url\("?).*?\/images\/(.+?)("?\))/) do |matched_string|
        matched_data = [matched_string, $1, $2, $3]
      
        "#{ matched_data[1] }<%= image_path('er_crm/#{ matched_data[2] }') %>#{ matched_data[3] }"
      end ; nil
      
      file = File.open(destination_file_path_for(file_path), "w")
      file.write( adjusted_content )
      file.close
      
      File.rename(destination_file_path_for(file_path), "#{ destination_file_path_for(file_path) }.erb")
    end 
  end
  
  def self.source_file_path_for(file_path)
    "#{root_path}/public/designs/stylesheets/#{ file_path }"
  end
  
  def self.destination_file_path_for(file_path)
    "#{root_path}/app/assets/stylesheets/er_crm/#{ file_path }"
  end

  def self.root_path
    File.expand_path("../", File.dirname(__FILE__))
  end
end