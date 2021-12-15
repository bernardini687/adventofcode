def data
  @data ||= begin
    template, *rules = DATA.readlines(chomp: true)
    {
      template: template.chars,
      rules: _parse_rules(rules.reject(&:empty?))
    }
  end
end

def _parse_rules(rules)
  rules.each_with_object({}) do |rule, obj|
    pair, insertion = rule.split(' -> ')
    obj[pair] = insertion
  end
end

def step(template)
  template.push('').each_cons(2).with_object([]) do |pair, obj|
    insertion = RULES[pair.join]

    if insertion
      obj.push pair.first, insertion
    else
      obj.push pair.first
    end
  end
end

RULES = data[:rules]

polymer = data[:template]

10.times {
  polymer = step(polymer)
}

counts = polymer.tally

puts "(part 1): #{counts.values.max - counts.values.min}"

__END__
HBHVVNPCNFPSVKBPPCBH

HV -> B
KS -> F
NH -> P
OP -> K
OV -> C
HN -> O
FF -> K
CP -> O
NV -> F
VB -> C
KC -> F
CS -> H
VC -> F
HF -> V
NK -> H
CF -> O
HH -> P
FP -> O
OH -> K
NN -> C
VK -> V
FB -> F
VP -> N
FC -> P
SV -> F
NO -> C
VN -> S
CH -> N
FN -> N
FV -> P
CN -> H
PS -> S
VF -> K
BN -> S
FK -> C
BB -> H
VO -> P
KN -> N
ON -> C
BO -> S
VS -> O
PK -> C
SK -> P
KF -> K
CK -> O
PB -> H
PF -> O
KB -> V
CC -> K
OK -> B
CV -> P
PO -> O
SH -> O
NP -> F
CO -> F
SS -> P
FO -> K
NS -> O
PN -> H
PV -> V
KP -> C
BK -> B
BP -> F
NB -> C
OF -> O
OC -> O
HO -> C
SC -> K
HC -> C
HS -> B
KH -> N
FS -> N
PH -> O
PC -> V
BS -> O
KO -> F
SP -> K
OB -> O
SF -> K
KV -> F
NC -> B
SO -> C
CB -> S
VH -> V
FH -> F
SN -> V
SB -> P
PP -> B
BF -> K
HB -> O
OO -> V
HP -> H
KK -> O
BV -> K
BH -> B
HK -> H
BC -> C
VV -> S
OS -> F
NF -> B
