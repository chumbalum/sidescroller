require 'game_state'
require 'player'
require 'bullet'
require 'timer'
require 'enemy'
require 'explosion'
require 'gameover'
require 'levelparser'

class Playing < GameState
  
  
  def initialize(window, gameengine)
    super(window, gameengine)
    @player = Player.new(window)
    @levelparser = Levelparser.new
    
    @bullets = []
    @enemyBullets = []
    @enemies = []
    @explosions = []

    @timer = Timer.new
  end
  
  def update
    
    acc = 0
    acc += 1 if(@window.button_down?(Gosu::KbDown))
    acc -= 1 if(@window.button_down?(Gosu::KbUp))
    @player.move(acc)

    @bullets.each{|bullet| bullet.update}
    @enemies.each{|enemy| enemy.update}
    @explosions.each{|explosion| explosion.update}
    @enemyBullets.each{|bullet| bullet.update}
    
    @bullets.reject!{|bullet|
      @enemies.reject!{|enemy|
        if(bullet.collides_with(enemy))
          @explosions << Explosion.new(@window, enemy.x, enemy.y)
          Game.sounds[:explosion].play
          true
        end
      } || (bullet.x > 800)
    }
    
        
    @enemyBullets.reject!{|bullet|      
      if(bullet.collides_with(@player))
        @player.get_damage
        true
      elsif(bullet.x < 0)
        true
      else
        false
      end
    }
    
    @explosions.reject!{|explosion|
      explosion.dead?
    }
    
    @enemies.reject!{|enemy|      
      if(enemy.x + enemy.width < 0)
        true
      elsif(enemy.collides_with(@player))
        Game.sounds[:explosion].play
        @player.get_damage
        @explosions << Explosion.new(@window, enemy.x, enemy.y)
        true
      end
    }  
    
    if(@timer.time_passed?(500))
      wave = @levelparser.next_wave
      if(!wave.nil?)
        wave.each_index{|index|
          case wave[index]
            when "X"
              @enemies << Enemy.new(@window, 800, index*60+37/2, @enemyBullets)
          end
        }
      end
    end
    
    
    if(@player.life == 0)
      @gameengine.popState
      @gameengine.pushState(Gameover.new(@window, @gameengine))
    end
    
  end
    
  def draw
    Game.images[:background].draw(0,0,0)
    @player.draw
    @enemies.each{|enemy| enemy.draw}
    @bullets.each{|bullet| bullet.draw}
    @enemyBullets.each{|bullet| bullet.draw}
    @explosions.each{|explosion| explosion.draw }
  end
  
  def button_down(id)
    case id
      when Gosu::KbEscape
        @gameengine.popState    
      when Gosu::KbSpace
        @bullets << Bullet.new(@window, @player.x+@player.width-4, @player.y+@player.height/2-1)
        Game.sounds[:shot].play
    end
  end
  
end