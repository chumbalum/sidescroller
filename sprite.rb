class Sprite
  
  attr_reader :x, :y
  
  def initialize(window, animation, x=0, y=0)
    @window = window
    @animation = animation
    @image = @animation.first
    
    @x = x
    @y = y
        
    @dead = false
  end
  
  def draw
    @image.draw(@x, @y, 0) if !dead?
    @image = @animation[Gosu::milliseconds / 50 % @animation.size]
  end
    
  def height
    @image.height
  end
  
  def width
    @image.width
  end
  
  def collides_with(other)
    x+width > other.x and x < other.x+other.width and
    ((y+height > other.y and y < other.y+other.height) or (y < other.y+other.height and y+height > other.y))
  end
  
  def kill
    @dead = true
  end
  
  def dead?
    @dead
  end
  
end