// testPuzzle = document.querySelector('pre > code').textContent.trimRight().split('\n')
puzzle = document.body.textContent.trimRight().split('\n')

function part1(puzzle) {
  const actions = Navigation.decodeActions(puzzle)
  const navigator = new Navigation('E')

  for (const [action, amount] of actions) {
    navigator.takeAction(action, amount)
  }

  console.log(navigator)

  return navigator.calcManhattanDistance()
}

// helpers:
class Navigation {
  constructor(dir) {
    this.dir = dir
    this.v = 0 // north-south
    this.h = 0 // east-west
  }

  static decodeActions(puzzle) {
    return puzzle.map(instruction => [instruction[0], Number(instruction.slice(1))])
  }

  takeAction(action, amount) {
    switch (action) {
      case 'N':
        this.v += amount
        break
      case 'S':
        this.v -= amount
        break
      case 'E':
        this.h += amount
        break
      case 'W':
        this.h -= amount
        break
      case 'L':
        this.rotate(-amount)
        break
      case 'R':
        this.rotate(amount)
        break
      case 'F':
        this.takeAction(this.dir, amount)
        break
      default:
        throw new Error(`'${action}' is not a valid action`)
    }
  }

  // TODO: refactor
  rotate(amount) {
    const target = Math.abs(amount / 90)

    if (amount > 0) {
      const cw = ['E', 'S', 'W', 'N']
      const current = cw.indexOf(this.dir)
      this.dir = cw[(current + target) % 4]
    } else {
      const ccw = ['E', 'N', 'W', 'S']
      const current = ccw.indexOf(this.dir)
      this.dir = ccw[(current + target) % 4]
    }
  }

  calcManhattanDistance() {
    return Math.abs(this.v) + Math.abs(this.h)
  }
}
