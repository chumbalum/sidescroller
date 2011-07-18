require 'sprite'
require 'enemybullet'

class Enemy < Sprite
  
  def initialize(window, x, y, enemyBullets)
    super(window, Game.images[:enemy], x, y)
      
    
    @enemyBullets = enemyBullets
    
    @velocity = 3
    
    @timer = Timer.new
  end
  
  def update
    @x -= @velocity
    
    if(@timer.time_passed?(1000+rand(5000)))
      @enemyBullets << Enemybullet.new(@window, @x, @y+height/2)
    end
  end
      
end