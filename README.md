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
  return puzzle.filter(e => checkPwd(dissectPolicy(e))).length
}

function part2(puzzle) {
  return puzzle.filter(e => checkPwdV2(dissectPolicy(e))).length
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
