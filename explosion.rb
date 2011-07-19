require 'sprite'

class Explosion < Sprite
  
  def initialize(window, x, y)
    super(window, Game.images[:explosion], x, y)
    @lifetime = @animation.size
  end
  
  def update
    kill if(@lifetime <= 0)
  end
  
  def draw
    @lifetime -= 1
    @image = @animation[@lifetime]
    @image.draw(@x, @y, 0) if !dead?
  end
    
end