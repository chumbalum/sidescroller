# schissl fuer ocra
$: << File.expand_path(File.dirname("./"))

require 'gosu'
require 'game_engine'

require 'main_menu'
require 'playing'
require 'options'

class Game < Gosu::Window
  
  def initialize
    super(800, 600, false)
    self.caption = "Sidescroller"
    
    @gameengine = GameEngine.new(self)
    @gameengine.pushState(MainMenu.new(self, @gameengine))
    
    @@images = {}
    @@fonts = {}
    @@sounds = {}
      
    load_images
    load_fonts
    load_sounds
    
    Game.sounds[:music].play
  end

  # Override
  def update
    @gameengine.update
  end
  
  # Override
  def draw
    @gameengine.draw
  end
  
  # Override
  def button_down(id)
    @gameengine.button_down(id)
  end
  
  # Override
  def button_up(id)
    @gameengine.button_up(id)
  end
  
  # Class Methods
  
  def load_images
    @@images[:background] = Gosu::Image.new(self, "images/background.png", false)
    
    # Sprites
    @@images[:bullet] = [Gosu::Image.new(self, "images/bullet.png", false)]
    @@images[:enemybullet] = [Gosu::Image.new(self, "images/enemybullet.png", false)] 
    @@images[:enemy] = [Gosu::Image.new(self, "images/enemy.png", false)]
    @@images[:player] = [Gosu::Image.new(self, "images/player.png", false)]
    @@images[:explosion] = Gosu::Image::load_tiles(self, "images/explosion.png", 32, 32, false)
  end
    
  def load_fonts
    font = "Consolas"
    @@fonts[:menu] = Gosu::Font.new(self, font, 40)
    @@fonts[:game] = Gosu::Font.new(self, font, 30)
  end
  
  def load_sounds
    @@sounds[:shot] = Gosu::Sample.new(self, "sounds/shot.wav")
    @@sounds[:explosion] = Gosu::Sample.new(self, "sounds/explosion.wav")
      
    @@sounds[:menu_scrolling] = Gosu::Sample.new(self, "sounds/menu_scrolling.wav")
    @@sounds[:menu_select] = Gosu::Sample.new(self, "sounds/menu_select.wav")
      
    @@sounds[:music] = Gosu::Sample.new(self, "sounds/music.mp3")
  end
  
  def self.images
    @@images
  end
  
  def self.fonts
    @@fonts
  end
  
  def self.sounds
    @@sounds
  end
  
end

Game.new.show