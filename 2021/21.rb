def state(state = DATA)
  @state ||= begin
    DATA.readlines(chomp: true).map { |l| _parse_line l }
  end
end

def _parse_line(line)
  {
    pos: line[-1].to_i,
    score: 0
  }
end

def run(players = state)
  @dice_roll = 1
  @rolls_count = 0

  until _winner? players do
    players.map! { |p| _take_turn p }
  end

  p @rolls_count

  players
end

def _winner?(players)
  players.any? { |p| p[:score] > 999 }
end

def _take_turn(player)
  rolls = []

  3.times {
    @dice_roll = 1 if @dice_roll > 100

    rolls << @dice_roll
    @dice_roll += 1
  }

  @rolls_count += 3

  pos = (player[:pos] + rolls.sum) % 10
  pos = pos.zero? ? 10 : pos

  player[:pos] = pos
  player[:score] += pos
  player
end

puts "(part 1): #{run}"

__END__
Player 1 starting position: 1
Player 2 starting position: 6
