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

    @bullets.each{|bullet| 
      bullet.update 
      bullet.kill if(bullet.x > 800)
      @enemies.each{|enemy|
        if bullet.collides_with(enemy)
          bullet.kill
          enemy.kill
          Game.sounds[:explosion].play
          @explosions << Explosion.new(@window, enemy.x, enemy.y)
        end
      }
    }
          
    @enemyBullets.each{|bullet| 
      bullet.update
      
      bullet.kill if(bullet.x < 0)
      if(bullet.collides_with(@player))
        bullet.kill
        @player.get_damage
      end
    }
    
    @explosions.each{|explosion| explosion.update }
      
    @enemies.each{|enemy|
      enemy.update
      
      if(enemy.collides_with(@player))
        enemy.kill
        Game.sounds[:explosion].play
        @player.get_damage
        @explosions << Explosion.new(@window, enemy.x, enemy.y)
      elsif(enemy.x+enemy.width < 0)
        enemy.kill 
      end
    }
    
         
    if(@player.life == 0)
      @gameengine.popState
      @gameengine.pushState(Gameover.new(@window, @gameengine))
    end
    
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
    
    cleanup
  end
    
  def draw
    Game.images[:background].draw(0,0,0)
            
    @player.draw
    @enemies.each{|enemy| enemy.draw}
    @bullets.each{|bullet| bullet.draw}
    @enemyBullets.each{|bullet| bullet.draw}
    @explosions.each{|explosion| explosion.draw }
      
  end
  
  def cleanup
    @bullets.delete_if{|bullet| bullet.dead?}
    @enemyBullets.delete_if{|bullet| bullet.dead?}
    @enemies.delete_if{|enemy| enemy.dead?}
    @explosions.delete_if{|explosion| explosion.dead? }
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