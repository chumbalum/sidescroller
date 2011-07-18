require 'sprite'

class Bullet < Sprite
   
  def initialize(window, x, y)    
    super(window, Game.images[:bullet], x, y)
      
    @velocity = 10
  end
  
  def update
    @x += @velocity
  end
  
end