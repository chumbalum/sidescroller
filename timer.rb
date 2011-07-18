class Timer
  
  def initialize
    @lastTime = Gosu::milliseconds
  end
  
  def time_passed?(ms)
    newTime = Gosu::milliseconds
    if(newTime-@lastTime > ms)
      @lastTime = newTime
      true
    else
      false
    end
  end
  
end