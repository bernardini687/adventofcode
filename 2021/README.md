# advent of code 2021

### day 1

```js
// const input = document.querySelector('pre > code').textContent.trimRight().split('\n')
const input = document.body.textContent.trimRight().split('\n')

let increments = 0

input.map(Number).reduce((previous, current) => {
  if (current > previous) {
    increments++
  }

  return current
}, Number.MAX_VALUE)

console.log(increments)
```

```js
// const input = document.querySelector('pre > code').textContent.trimRight().split('\n')
const input = document.body.textContent.trimRight().split('\n')

const triSums = input.map(Number).reduce((result, current, i, arr) => {
  const third = arr[i + 2]
  if (!third) {
    return result
  }

  result.push(current + arr[i + 1] + third)

  return result
}, [])

// console.log(triSums)

let increments = 0

triSums.reduce((previous, current) => {
  if (current > previous) {
    increments++
  }

  return current
}, Number.MAX_VALUE)

console.log(increments)
```

### day 2

```js
// const input = document.querySelector('pre > code').textContent.trimRight().split('\n')
const input = document.body.textContent.trimRight().split('\n')

// const pos = input.reduce(
//   (pos, action) => {
//     const [dir, amount] = action.split(' ')

//     switch (dir) {
//       case 'forward':
//         pos.h += Number(amount)
//         break
//       case 'down':
//         pos.d += Number(amount)
//         break
//       case 'up':
//         pos.d -= Number(amount)
//         break
//     }

//     return pos
//   },
//   { h: 0, d: 0 }
// )

const pos = input.reduce(
  (pos, action) => {
    const [dir, num] = action.split(' ')

    const amount = Number(num)

    switch (dir) {
      case 'forward':
        pos.h += amount
        pos.d += amount * pos.aim
        break
      case 'down':
        pos.aim += amount
        break
      case 'up':
        pos.aim -= amount
        break
    }

    return pos
  },
  { h: 0, d: 0, aim: 0 }
)

console.log(pos.h * pos.d)
```

### day 3

```js
/*
 * PART 1
 */

// const input = document.querySelector('pre > code').textContent
const input = document.body.textContent

const size = input.indexOf('\n')

const columns = input
  .trimRight()
  .split('\n')
  .reduce((acc, line) => {
    // iterate over the columns
    for (let i = 0; i < size; i++) {
      if (acc[i] === undefined) {
        acc[i] = { 0: 0, 1: 0 } // build an object that will count the number of zeros and ones in a column
      } else {
        acc[i][line[i]]++ // update the count of zeros and ones of this column
      }
    }
    return acc
  }, [])

const gammaRate = columns.reduce(
  (acc, col) => (acc += Object.keys(col).reduce((zero, one) => (col[zero] > col[one] ? zero : one))),
  ''
)

const epsilonRate = gammaRate
  .split('')
  .map(bit => (1 - bit).toString())
  .join('')

console.log(parseInt(gammaRate, 2) * parseInt(epsilonRate, 2))

/*
 * PART 2 🔥
 */

var input = document.documentURI.includes('input') ? document.body : document.querySelector('pre > code')
input = input.textContent.trimRight().split('\n')

function pickRating(data, criteria) {
  var oneMatches = []
  var zeroMatches = []

  for (let i = 0; i < data[0].length; i++) {
    if (data.length === 1) {
      break
    }

    data.forEach(bits => {
      if (bits[i] === '1') {
        oneMatches.push(bits)
      } else {
        zeroMatches.push(bits)
      }
    })

    if (criteria(oneMatches.length, zeroMatches.length)) {
      data = [...oneMatches]
    } else {
      data = [...zeroMatches]
    }

    oneMatches = []
    zeroMatches = []
  }

  return data
}

var o2 = pickRating(input, (a, b) => a >= b)
var co2 = pickRating(input, (a, b) => a < b)

console.log(parseInt(o2, 2) * parseInt(co2, 2))
```

### day 4

```js
class Game {
  constructor(nums, boards) {
    this.nums = nums
    this.picks = 0
    this.boards = boards
    this.winners = []
    this.winNums = []
  }

  advance() {
    const num = this.nums.shift()
    this.picks++

    console.log(`num: ${num}, picks: ${this.picks}`)

    this.boards.forEach(board => {
      board.mark(num)
    })

    if (this.picks > 4) {
      while (this.checkWinners(num) > -1) {} // there can be multiple winners for the same number!
    }
  }

  checkWinners(num) {
    const found = this.boards.findIndex(board => board.isBingo())
    console.log(`is bingo: ${JSON.stringify(this.boards[found])}, boards size: ${this.boards.length}`)

    if (found !== -1) {
      this.winners.push(this.boards[found])
      this.winNums.push(num)
      this.boards.splice(found, 1) // remove the winning board from the others
      console.log(`new winner! board winners size: ${this.winners.length}, called num: ${num}`)
    } else {
      console.log('still no winners')
    }

    return found
  }
}

class Board {
  constructor(data) {
    this.rows = this._buildRows(data)
    this.size = this.rows[0].length
  }

  mark(num) {
    this.rows.forEach((row, i) => {
      const found = row.findIndex(cell => !cell.marked && cell.num === num)

      if (found !== -1) {
        console.log(`this board have ${num} here: [${i}][${found}]!`)
        this.rows[i][found] = { num, marked: true }
      }
    })
  }

  isBingo() {
    let bingo = false

    bingo = this.rows.findIndex(row => row.every(cell => cell.marked)) > -1

    if (!bingo) {
      // check vertical bingo
      for (let i = 0; i < this.size; i++) {
        const col = this.rows.map(row => row[i])
        if (col.every(cell => cell.marked)) {
          bingo = true
          break
        }
      }
    }

    return bingo
  }

  _buildRows(data) {
    return data.split('\n').map(row => {
      const r = row.trim().split(/\s+/)

      return r.map(num => ({ num, marked: false }))
    })
  }
}

let input = document.documentURI.includes('input') ? document.body : document.querySelector('pre > code')
input = input.textContent.trimRight().split('\n\n')

const [_numbers, ..._boards] = input

const numbers = _numbers.split(',')
const boards = _boards.map(b => new Board(b))

const game = new Game([...numbers], [...boards])

while (game.boards.length > 0 && game.picks < 85) {
  // `(game.winners.length < 1)` for part 1
  game.advance()
}

const winner = game.winners[game.winners.length - 1] // `[0]` for part 1
const winNum = game.winNums[game.winNums.length - 1] // `[0]` for part 1

const sumOfUnmarked = winner.rows
  .flatMap(row => row.filter(cell => !cell.marked))
  .reduce((sum, cell) => {
    sum += Number(cell.num)
    return sum
  }, 0)

console.log(sumOfUnmarked * winNum)
```

### day 5

### day 6

```js
var input = document.documentURI.includes("input")
  ? document.body
  : document.querySelector("pre > code");
input = input.textContent.split(",").map(Number);

function runSimulation(t, state) {
  for (i = 0; i < t; i++) {
    let newborns = 0;
    state = state.map((f) => {
      if (f > 0) {
        return f - 1;
      } else {
        newborns++;
        return 6;
      }
    });
    if (newborns > 0) {
      state.push(...new Array(newborns).fill(8));
    }
  }
  return state;
}

console.log(runSimulation(80, input).length); // part 1
```

### [day 7](07.rb)

### [day 8](08.rb)

### [day 9](09.rb)

### [day 10](10.rb)

### [day 14](14.rb)
