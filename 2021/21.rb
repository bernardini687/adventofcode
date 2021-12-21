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
  d100 = (1..100).to_a # TODO: wrap around 100!

  # while players.any { |p| p[:score] < 1000 }

  players.map! { |p| _take_turn p, d100.shift(3) }

  # players find one with least score
  # number of rolls
end

def _take_turn(player, rolls)
  p rolls
  # advance `pos` by rolls.sum and increase score by `pos`
  player
end

puts "(part 1): #{run}"

__END__
Player 1 starting position: 4
Player 2 starting position: 8
