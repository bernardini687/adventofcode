def run(input = data)
  p input
end

def data(data = DATA)
  @data ||= DATA.readlines
end

puts "(part 1): #{run}"

__END__
