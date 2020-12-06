# advent of code 2020

### day 1

```js
puzzle = document.body.textContent.trimRight().split('\n').map(Number)

function part1(puzzle) {
  while (puzzle.length) {
    let seats = puzzle.pop()

    for (const x of puzzle) {
      if (seats + x === 2020) {
        return seats * x
      }
    }
  }
}

function part2(puzzle) {
  while (puzzle.length) {
    let seats = puzzle.pop()

    for (const x of puzzle) {
      for (const y of puzzle) {
        if (seats + x + y === 2020) {
          return seats * x * y
        }
      }
    }
  }
}
```

### day 2

```js
puzzle = document.body.textContent.trimRight().split('\n').map(Number)

function part1(puzzle) {
  return puzzle.filter(p => checkPwd(dissectPolicy(p))).length
}

function part2(puzzle) {
  return puzzle.filter(p => checkPwdV2(dissectPolicy(p))).length
}

// helpers:
function dissectPolicy(rawPolicy) {
  const [range, char, pwd] = rawPolicy.split(/\s+/)
  const [min, max] = range.split('-').map(Number)

  return {
    min,
    max,
    char: char[0],
    pwd,
  }
}

function checkPwd({ min, max, char, pwd }) {
  const count = pwd.split(char).length - 1
  return count <= max && count >= min
}

function checkPwdV2({ min: pos1, max: pos2, char, pwd }) {
  return (pwd[pos1 - 1] === char) !== (pwd[pos2 - 1] === char)
}
```

### day 3

```js
testPuzzle = document.querySelector('pre > code').textContent.trimRight().split('\n')
puzzle = document.body.textContent.trimRight().split('\n')

function part1(puzzle) {
  return countTrees(puzzle, 3, 1)
}

function part2(puzzle) {
  return [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ].reduce((acc, [rightSlope, downSlope]) => (acc *= countTrees(puzzle, rightSlope, downSlope)), 1)
}

// helpers:
function countTrees(treesMap, rightSlope, downSlope) {
  const patternLength = treesMap[0].length
  let currCol = 0
  let trees = 0

  for (rowIndex = downSlope; rowIndex < treesMap.length; rowIndex += downSlope) {
    currCol += rightSlope
    if (treesMap[rowIndex][currCol % patternLength] === '#') {
      trees++
    }
  }

  return trees
}
```

### day 4

```js
testPuzzles = document.querySelectorAll('pre > code')

part1Test = testPuzzles[0].textContent.split('\n\n')
part2InvalidsTest = testPuzzles[2].textContent.split('\n\n')
part2ValidsTest = testPuzzles[3].textContent.split('\n\n')

puzzle = document.body.textContent.split('\n\n')

function part1(puzzle) {
  return puzzle.filter(p =>
    checkPassport(dissectPassport(p), ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'])
  ).length
}

function part2(puzzle) {
  return puzzle.filter(p => checkPassportV2(dissectPassport(p), Object.keys(validators))).length
}

const validators = {
  byr: /^(19[2-9][0-9]|200[0-2])$/,
  iyr: /^20(1[0-9]|20)$/,
  eyr: /^20(2[0-9]|30)$/,
  hgt: /^(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)$/,
  hcl: /^#[0-9a-f]{6}$/,
  ecl: /^(amb|blu|brn|gry|grn|hzl|oth)$/,
  pid: /^\d{9}$/,
}

// helpers:
function dissectPassport(rawPassport) {
  return Object.fromEntries(rawPassport.split(/\s+/).map(pair => pair.split(':')))
}

function checkPassport(passport, requiredFields) {
  const passportFields = Object.keys(passport)
  return requiredFields.every(field => passportFields.includes(field))
}

function checkPassportV2(passport, requiredFields) {
  const passportFields = Object.keys(passport)
  return requiredFields.every(
    field => passportFields.includes(field) && validators[field].test(passport[field])
  )
}
```

### day 5

```js
puzzle = document.body.textContent.trimRight().split('\n')

function part1(puzzle) {
  return Math.max(...puzzle.map(calcSeatId))
}

function part2(puzzle) {
  logNonConsecutiveSeat(puzzle.map(calcSeatId).sort((a, b) => a - b))
}

// helpers:
function halve(seats, directions) {
  const dir = directions.shift()
  if (!dir) return seats

  if ('FL'.includes(dir)) {
    // upper half
    return halve(seats.slice(0, seats.length / 2), directions)
  } else {
    // lower half
    return halve(seats.slice(seats.length / 2), directions)
  }
}

function* range(min, max) {
  for (let i = min; i < max; i++) yield i
}

function decodeRow(boardingPass) {
  const rows = Array.from(range(0, 128))
  return halve(rows, boardingPass.slice(0, -3).split(''))
}

function decodeCol(boardingPass) {
  const cols = Array.from(range(0, 8))
  return halve(cols, boardingPass.slice(-3).split(''))
}

function calcSeatId(boardingPass) {
  const [row] = decodeRow(boardingPass)
  const [col] = decodeCol(boardingPass)
  return row * 8 + col
}

function logNonConsecutiveSeat(seats) {
  for (i = 0; i < seats.length; i++) {
    if (seats[i] + 1 !== seats[i + 1]) {
      console.log(seats[i] + 1)
      break
    }
  }
}
```

### day 6

```js
testPuzzle = document.querySelectorAll('pre > code')[1].textContent.trimRight().split('\n\n')
puzzle = document.body.textContent.trimRight().split('\n\n')

function part1(puzzle) {
  return puzzle.reduce((tot, group) => (tot += uniqYesAnswers(group)), 0)
}

function part2(puzzle) {
  return puzzle.reduce((tot, group) => (tot += crossYesAnswers(group)), 0)
}

// helpers:
function uniqYesAnswers(group) {
  return new Set(Array.from(group.replace(/\n/g, ''))).size
}

function crossYesAnswers(group) {
  const groupAnswers = group.split('\n').map(answers => answers.split(''))

  // build an intersection of the newline-separated answers
  // [[a,b],[a,c],[a,d]] -> [a]
  return groupAnswers.reduce((a, b) => a.filter(c => b.includes(c))).length
}
```
