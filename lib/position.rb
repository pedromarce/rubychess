class Position 
  include Comparable
  
  attr_reader :ordinal, :x, :y
  
  def initialize x, y
    @x, @y = x, y
    @ordinal = x + y * 8;
  end
  
  @@position = Array.new  
  (0..7).each do |x|
    (0..7).each do |y|
      p = Position.new x, y
      @@position[x + y * 8] = p 
    end
  end
  
  ILLEGAL = Position.new(-1, -1) do
    def neighbour dir
      ILLEGAL
    end
  end 
  
  def self.create pos
    case pos
    when Position
      return pos
    when Numeric
      @@position[pos]
    else
      byte_x, byte_y = pos.to_s.upcase.bytes.map(&:to_i)
      x = byte_x - 65;
      y = byte_y - 49;
      raise "x must be between 0..7" unless (0..7).include? x
      raise "y must be between 0..7" unless (0..7).include? y
    @@position[x + y * 8]
    end    
  end  
  
  def <=>(anOther)
    ordinal <=> anOther.ordinal
  end
  
  def neighbour dir
    case dir
      when :n then go_n
      when :ne then go_ne
      when :e then go_e
      when :se then go_se
      when :s then go_s
      when :sw then go_sw
      when :w then go_w
      when :nw then go_nw
    end
  end
  
  def go *dirs
    dst = self
    dirs.each do |d| 
      dst = dst.neighbour(d)
      return dst if dst==ILLEGAL
    end
    return dst
  end
  
  def go_n
    return ILLEGAL if @y == 7
    Position.new @x, @y+1
  end
  
  def go_ne
    return ILLEGAL if @y == 7 || @x == 7
    Position.new @x+1, @y+1
  end
  
  def go_e
    return ILLEGAL if @x == 7
    Position.new @x+1, @y
  end
  
  def go_se
    return ILLEGAL if @x == 7 || @y == 0
    Position.new @x+1, @y-1
  end
  
  def go_s
    return ILLEGAL if @y == 0
    Position.new @x, @y-1
  end
  
  def go_sw
    return ILLEGAL if @x == 0 || @y == 0
    Position.new @x-1, @y-1
  end
  
  def go_w
    return ILLEGAL if @x == 0
    Position.new @x-1, @y
  end
  
  def go_nw
    return ILLEGAL if @x == 0 || @y == 7
    Position.new @x-1, @y+1
  end
  
  def all_neighbours 
    neighbours = Array.new << go_n << go_ne << go_e << go_se << go_s << go_sw << go_w << go_nw
    neighbours.delete_if { |n| n==ILLEGAL }
  end
  
  def to_s
   ('A'..'H').to_a[@x] + (@y+1).to_s
  end
end
