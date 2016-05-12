class Game
  attr_accessor :current_player, :previous_player, :fragment, :losses, :players

  def initialize(*players)
    players = [Player.new("A"), Player.new("B"), Player.new("C")] if players.empty?
    @dictionary = []
    File.open("ghost-dictionary.txt").each { |line| @dictionary << line.chomp }
    @fragment = ""
    @players = [*players]
    @current_player = @players.first
    @losses = {}
      @players.each { |player| @losses[player] = 0 }
  end

  def next_player!
    i = @players.find_index(@current_player)
    @current_player = @players[(i+1) % @players.length]
  end

  def run
    while true
      puts "-" * 20
      puts "This is a new round!"
      @players.each { |player| player.tell_current_status(@players) }
      play_round
      display_standings
      break if game_won?
      @fragment = ""
    end
    loser = @losses.key(5)
    puts "'#{loser.name}' lost the the game."
  end

  def display_standings
    @players.each do |player|
      puts "#{player.name} has '#{record(player)}.'"
    end
  end

  def play_round
    while true
      puts "current letters are '#{@fragment}'."
      puts "It's #{@current_player.name}'s turn."
      take_turn(@current_player)
      round_end? ? break : next_player!
    end
    puts "'#{@fragment}' is a word!"
    puts "#{@current_player.name} loses!"
    @losses[@current_player] += 1
    #@previous_player.losses += 1
  end

  def record(player_name)
    result = ""
    @losses[player_name].times do |idx|
      result << %w(G H O S T).at(idx)
    end
    result
  end

  def round_end?
    @dictionary.include?(@fragment)
  end

  def game_won?
    @players.each do |player|
      return true if @losses[player] == 5
    end
    false
  end

  def take_turn(player)
    players_guess = ""
    until valid_play?(players_guess)
      players_guess = @current_player.guess
      if valid_play?(players_guess) == false
        @current_player.alert_invalid_guess
      end
    end
    @fragment = @fragment + players_guess

  end

  def valid_play?(string)
    alphabet = ("a".."z").to_a
    if alphabet.include?(string)
      words = @dictionary.select {|word| word.start_with?("#{@fragment + string}")}
      return true unless words.empty?
    end
    false
  end



end

class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def guess
    puts "Choose a letter: "
    gets.chomp
  end

  def alert_invalid_guess
    puts "Your entry was invalid!"
  end

  def tell_current_status(players)
    print "The player(s) "
    players.each { |player| print "#{player.name}, " }
    print "are still in the game.\n"
  end

end

class AiPlayer
  attr_accessor :name, :player_num, :fragment

  def initialize(name)
    @name = name
    @player_num
    @fragment
  end

  def tell_current_status(players)
    @player_num = players.length
  end

end




#game1 = Game.new(Player.new("A"), Player.new("B"))
#game1.play_round
#game1.fragment = "tt"
#p game1.valid_play?("t")
