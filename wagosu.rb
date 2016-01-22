require 'gosu'
require_relative 'zorder'
require_relative 'player'
require_relative 'avatar'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new("media/space.png", tileable: true)

    @player = Player.new
    @player.warp(320, 240)

    @font = Gosu::Font.new(20)

    @stars = []
    @images = (0..408).to_a
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
    avatar = nil
    while avatar.nil?
      pick = rand(0..@images.length)
      begin
        avatar = Avatar.new(@images[pick])
      rescue
        @images.delete(pick)
        next
      end
    end
    @stars << avatar if rand(100) < 4 && @stars.size < 25
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @stars.each(&:draw)
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = GameWindow.new
window.show
