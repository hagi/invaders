require "bundler/setup"
require "hasu"

Hasu.load "bullet.rb"
Hasu.load "invader.rb"
Hasu.load "fighter.rb"


class Invaders < Hasu::Window
  WIDTH = 400
  HEIGHT = 600

  attr_reader :bullets

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @fighter = Fighter.new
    @invaders = []

    10.times do |i|
      @invaders << Invader.new(i)
    end

    @bullets = []
  end

  def draw
    @fighter.draw(self)
    @invaders.each { |invader| invader.draw(self) }
    @bullets.each { |bullet| bullet.draw(self) }
  end

  def update
    @invaders.each do |invader|
      @bullets << invader.fire unless invader.move! || @bullets.size > 10
    end

    @bullets.delete_if { |bullet| bullet.move! && (bullet.out? || bullet.hit_invader?(@invaders) || bullet.hit_fighter?(@fighter))  }

    if button_down?(Gosu::KbLeft)
      @fighter.left!
    end

    if button_down?(Gosu::KbRight)
      @fighter.right!
    end

    if button_down?(Gosu::KbUp) && can_fire?(@bullets)
      @bullets << @fighter.fire
    end
  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end

  def can_fire?(bullets)
     bullets.select { |bullet| bullet.direction < 0 }.size < 1
  end
end

Invaders.run
