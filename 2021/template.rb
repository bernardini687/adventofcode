def data(data = DATA)
  @data ||= DATA.readlines chomp: true
end

def run(input = data)
  p input
end

puts "(part 1): #{run}"

__END__
foo
