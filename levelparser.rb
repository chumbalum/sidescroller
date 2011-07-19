
class Levelparser
  
  def initialize
    
    @level = []
      
    @level_dir = Dir.entries("levels")
    
    @level_dir.shift
    @level_dir.shift
      
    file = File.new("levels/"+@level_dir.shift)
    file.each{|line| @level << line.strip.split(//) }
    file.close
  end
  
  def next_wave
    @level.shift
  end
  
end