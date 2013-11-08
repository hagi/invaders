class Invader
  WIDTH = 40
  HEIGHT = 16
  SPEED = 2

  attr_reader :x

  def initialize(idx)
    @y = 20 + idx * (HEIGHT + 10)
    @x = Invaders::WIDTH / 4 + rand(Invaders::WIDTH / 2)
    @direction = [1, -1].sample
  end

  def move!
    r = rand(500)
    return false if r == 0

    @direction = -1 if @x + SPEED * @direction > Invaders::WIDTH - WIDTH / 2 - 5
    @direction = 1 if @x + SPEED * @direction < WIDTH / 2 + 5

    @x += SPEED * @direction
  end

  def fire
    Bullet.new(@x, @y + HEIGHT, 1)
  end

  def right!
    @x += SPEED if @x < Invaders::WIDTH - WIDTH / 2
  end

  def x1
    @x - WIDTH / 2
  end

  def x2
    @x + WIDTH / 2
  end

  def y1
    @y - HEIGHT / 2
  end

  def y2
    @y + HEIGHT / 2
  end

  def draw(window)
    color = Gosu::Color::BLUE

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
