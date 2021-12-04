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
