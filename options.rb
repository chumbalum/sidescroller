require 'game_state'

class Options < GameState
  
  def initialize(window,  gameengine)
    super(window, gameengine)
    @menuItems = ["Difficulty", "Music", "Back"]
    @selectedItem = 0
  end
    
  def button_down(id)
    case id
      when Gosu::KbDown
        Game.sounds[:menu_scrolling].play
        @selectedItem = [(@selectedItem + 1), 2].min
      when Gosu::KbUp
        Game.sounds[:menu_scrolling].play
        @selectedItem = [(@selectedItem - 1), 0].max
      when Gosu::KbReturn
        Game.sounds[:menu_select].play
        case @selectedItem
          when 0 
            puts "not yet implemented"
          when 1
            puts "not yet implemented"
          when 2 
            @gameengine.popState
        end
    end
  end

  def draw
    Game.images[:background].draw(0,0,0)
    
    Game.fonts[:menu].draw_rel("Options", 400, 200, 0, 0.5, 1, 2, 2)
    @menuItems.each_index{|i|
      if(i == @selectedItem)
        Game.fonts[:menu].draw_rel(@menuItems[i], 400, 280+i*40, 0, 0.5, 1, 1, 1, Gosu::Color::RED)
      else
        Game.fonts[:menu].draw_rel(@menuItems[i], 400, 280+i*40, 0, 0.5, 1)
      end
    }
  end
  
end