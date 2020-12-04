# advent of code 2020

### day 1

```js
puzzle = document.body.textContent.trimRight().split('\n').map(Number)

function part1(puzzle) {
  while (puzzle.length) {
    let a = puzzle.pop()

    for (const x of puzzle) {
      if (a + x === 2020) {
        return a * x
      }
    }
  }
}

function part2(puzzle) {
  while (puzzle.length) {
    let a = puzzle.pop()

    for (const x of puzzle) {
      for (const y of puzzle) {
        if (a + x + y === 2020) {
          return a * x * y
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

### day 3

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
