class GameEngine
      
  def initialize(window)
    @window = window
    @states = []
  end
    
  def update
    @states.last.update
  end
  
  def draw
    @states.last.draw
  end
  
  def button_down(id)
    @states.last.button_down(id)
  end
  
  def button_up(id)
    @states.last.button_up(id)
  end
  
  def pushState(state)
    @states << state
  end
  
  def popState
    @states.pop
    if(@states.empty?)
      exit(0)
    end
  end
       
end