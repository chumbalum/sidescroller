require 'sprite'

class Enemybullet < Sprite
  
  def initialize(window,x,y)
    super(window, Game.images[:enemybullet],x,y)
    @velocity = 6
  end
  
  def update
    @x -= @velocity
  end
  
end