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
