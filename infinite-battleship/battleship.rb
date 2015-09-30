require 'set'

class Ship
  def initialize points=[]
    @points = Set.new points
  end

  def hit? shots
    @points.intersect? shots
  end

  def sunk? shots
    @points.subset? shots
  end

  def self.build x, y, horizontal
    if horizontal
      new (x...x+size).zip(Array.new(size) {y})
    else
      new Array.new(size) {x}.zip(y...y+size)
    end
  end
end

class Battleship < Ship ; def self.size() 4 end end

class Player
  def initialize grid_size, ships, shots=[]
    @grid_size = grid_size
    @ships = ships
    @shots = Set.new shots
  end

  def incoming! point
    old = self.class.new @grid_size, @ships.dup, @shots.dup
    @shots << point

    yield Shot.new self, hits - old.hits, sunk - old.sunk, point
  end

  def next_move
    Array.new(2) { rand(@grid_size + 5) }
  end

  def lost?
    @ships == sunk
  end

  def sunk
    @ships.select {|ship| ship.sunk? @shots }
  end

  def hits
    @ships.select {|ship| ship.hit? @shots }
  end
end

Shot = Struct.new :defender, :hits, :sunk, :point do
  def miss? ; hits.none? && sunk.none? ; end
  def game_over? ; defender.lost? ; end
end

class Game
  def self.build size
    ship = Battleship.build rand(size), rand(size), [true, false].sample

    player = Player.new size, [ship]

    new [player]
  end

  def initialize players=[]
    @players = players
  end

  def start &block
    @players.cycle.each_cons(2) do |attacker, defender|
      defender.incoming! attacker.next_move, &block
    end
  end
end

if __FILE__ == $0
  Game.build(1).start do |result|
    print "#{result.point}... "

    result.hits.each do |ship|
      puts "Hit my #{ship.class}"
    end

    result.sunk.each do |ship|
      puts "Sunk my #{ship.class}"
    end

    puts "Splash" if result.miss?

    if result.game_over?
      abort "Game over!"
    end
  end
end
