# advent of code 2020

```js
i = document.body.textContent.trimRight().split('\n').map(Number)
```

### day 1

```js
function part1(i) {
  while (i.length) {
    let a = i.pop()

    for (const x of i) {
      if (a + x === 2020) {
        return a * x
      }
    }
  }
}

function part2(i) {
  while (i.length) {
    let a = i.pop()

    for (const x of i) {
      for (const y of i) {
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
function part1(i) {
  return i.filter(e => pwdCheck(policyDissect(e))).length
}

function part2(i) {
  return i.filter(e => pwdCheckV2(policyDissect(e))).length
}

// helpers
function policyDissect(rawPolicy) {
  const [range, char, pwd] = rawPolicy.split(/\s+/)
  const [min, max] = range.split('-').map(Number)

  return {
    min,
    max,
    char: char[0],
    pwd,
  }
}

function pwdCheck({ min, max, char, pwd }) {
  const count = pwd.split(char).length - 1
  return count <= max && count >= min
}

function pwdCheckV2({ min: pos1, max: pos2, char, pwd }) {
  return (pwd[pos1 - 1] === char) !== (pwd[pos2 - 1] === char)
}
```
