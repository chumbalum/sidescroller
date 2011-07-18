require 'game_state'

class Gameover < GameState
  
  def initialize(window, gameengine)
    super(window, gameengine)
    @timer = Timer.new
  end
  
  def draw
    Game.images[:background].draw(0,0,0)
    Game.fonts[:menu].draw_rel("Game Over", 400, 200, 0, 0.5, 1, 2, 2)
  end
  
  def button_down(id)
    case id
      when Gosu::KbReturn
      @gameengine.popState
    end
  end
  
end