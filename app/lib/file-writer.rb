class FileWriter
  attr_accessor :path, :file_handler

  def initialize(path)
    @path = path
    @file_handler = File.open(path, 'w+')
  end

  def write(content)
    @file_handler.write("#{content}\n")
  end

  def close
    @file_handler.close
  end

end