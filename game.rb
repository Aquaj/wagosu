require 'gosu'
require_relative 'zorder'
require_relative 'player'
require_relative 'star'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new("media/space.png", tileable: true)

    @player = Player.new
    @player.warp(320, 240)

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = []
  end

  def update
    @player.turn_left if Gosu.button_down? Gosu::KbLeft
    @player.turn_right if Gosu.button_down? Gosu::KbRight
    @player.accelerate if Gosu.button_down? Gosu::KbUp
    @player.move
    @player.collect_stars(@stars)

    rand_stars
  end

  def rand_stars
    @stars.push(Star.new(@star_anim)) if rand(100) < 4 && @stars.size < 25
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @stars.each(&:draw)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = GameWindow.new
window.show
