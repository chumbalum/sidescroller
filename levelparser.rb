
class Levelparser
  
  def initialize
    
    @level = []
      
    file = File.new("levels/level1.txt")
    file.each{|line| @level << line.strip.split(//) }
    file.close
  end
  
  def next_wave
    @level.shift
  end
  
end