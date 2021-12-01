const EMPTY = 'L'
const FLOOR = '.'
const TAKEN = '#'

// let room = document.querySelector('pre > code').textContent.trimRight()
let room = document.body.textContent.trimRight()
const grid = room.split('\n').map(row => row.split(''))

room = room.replace(/\n/g, '').split('')

function part1(room) {
  let prevTakenCount = 0
  let takenCount = takeTurn(room)
  let turnCount = 1

  while (prevTakenCount !== takenCount) {
    prevTakenCount = takenCount
    takenCount = takeTurn(room)
    turnCount++
  }

  console.log('stabilized with: ', takenCount)
  console.log('number of turns: ', turnCount)
}

function takeTurn(room) {
  const reservedSeats = []
  const overpopulatedSeats = []

  for (let row = 0; row < grid.length; row++) {
    for (let col = 0; col < grid[0].length; col++) {
      if (room[seat(row, col)] === FLOOR) continue

      const neighboursCount = countNeighbours(room, row, col)

      if (room[seat(row, col)] === EMPTY && neighboursCount === 0) {
        reservedSeats.push([row, col])
        continue
      }

      if (room[seat(row, col)] === TAKEN && neighboursCount > 3) {
        overpopulatedSeats.push([row, col])
      }
    }
  }

  update(room, reservedSeats, TAKEN)
  update(room, overpopulatedSeats, EMPTY)

  return room.filter(seat => seat === TAKEN).length
}

function seat(row, col) {
  return row * grid[0].length + col
}

function update(room, seats, state) {
  for (const [row, col] of seats) {
    room[seat(row, col)] = state
  }
}

function countNeighbours(room, row, col) {
  return (
    count(room, row - 1, col - 1) +
    count(room, row - 1, col) +
    count(room, row - 1, col + 1) +
    count(room, row, col - 1) +
    count(room, row, col + 1) +
    count(room, row + 1, col - 1) +
    count(room, row + 1, col) +
    count(room, row + 1, col + 1)
  )
}

function count(room, row, col) {
  if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length) {
    return 0 // extra grid seats don't count
  }

  return room[seat(row, col)] === TAKEN ? 1 : 0
}
