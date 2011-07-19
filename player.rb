require 'sprite'

class Player < Sprite
  
  attr_writer :acceleration 
  attr_reader :life 
  
  def initialize(window)
    super(window, Game.images[:player])
      
    @x = 20
    @y = 300 - height/2
    
    @velocity = 5
    
    @life = 100
  end
  
  def move(acceleration)
    @y += @velocity*acceleration
    @y = 0 if(@y < 0)
    @y = 600-height if(@y > 600-height)
  end
    
  def get_damage
    if(@life > 0)
      @life -= 10
    end
  end
  
  def draw
    @window.draw_quad(9,9,Gosu::Color::WHITE, 211,9,Gosu::Color::WHITE,
                      9,21,Gosu::Color::WHITE, 211,21,Gosu::Color::WHITE)
    @window.draw_quad(10,10,Gosu::Color::RED, 10+@life*2,10,Gosu::Color::RED,
                      10,20,Gosu::Color::RED, 10+@life*2,20,Gosu::Color::RED)
    super
  end
          
end