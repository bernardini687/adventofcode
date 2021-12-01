# advent of code 2021

### day 1

```js
// const input = document.querySelector('pre > code').textContent.trimRight().split('\n')
const input = document.body.textContent.trimRight().split('\n')

let increments = 0

input.map(Number).reduce((prev, curr) => {
  if (curr > prev) {
    increments++
  }

  return curr
}, Number.MAX_VALUE)

console.log(increments)
```
