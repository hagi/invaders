class Bullet
  SIZE = 8
  SPEED = 2

  attr_reader :direction, :x, :y
  def initialize(x, y, direction = 1, speed = nil)
    @x = x
    @y = y
    @direction = direction # as multiplier
    @speed = speed || SPEED
  end

  def move!
    @y += @speed * @direction
  end

  def out?
    @y < 0 || @y > Invaders::HEIGHT
  end

  def hit_invader?(invaders)
    return false if direction > 0 # = bomb
    start = invaders.size
    invaders.delete_if { |invader| invader.hit_by?(self) }
    invaders.size < start
  end

  def hit_fighter?(fighter)
    false
  end

  def x1
    @x - SIZE / 2
  end

  def x2
    @x + SIZE / 2
  end

  def y1
    @y - SIZE / 2
  end

  def y2
    @y + SIZE / 2
  end

  def draw(window)
    color = Gosu::Color::WHITE

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end

end
