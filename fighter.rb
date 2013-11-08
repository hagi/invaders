class Fighter
  WIDTH = 40
  HEIGHT = 16
  SPEED = 6

  attr_reader :x

  def initialize
    @x = Invaders::WIDTH / 2
  end

  def left!
    @x -= SPEED if @x > WIDTH / 2
  end

  def right!
    @x += SPEED if @x < Invaders::WIDTH - WIDTH / 2
  end

  def fire
    Bullet.new(@x, y1 - 1, -1, 10)
  end


  def x1
    @x - WIDTH / 2
  end

  def x2
    @x + WIDTH / 2
  end

  def y1
    Invaders::HEIGHT - HEIGHT - 20
  end

  def y2
    Invaders::HEIGHT - 20
  end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color,
    )
  end

  def hit_by?(bullet)
    x1 < bullet.x &&
      x2 > bullet.x &&
      y1 < bullet.y &&
      y2 > bullet.y
  end
end
