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
