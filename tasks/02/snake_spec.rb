describe '#move' do
  it 'moves single lengthed snake correctly' do
    expect(move([[5, 7]], [0, 1])).
      to eq [[5, 8]]
  end

  it 'moves snake correctly upwards' do
    expect(move([[4, 5], [4, 6], [5, 6], [5, 7]], [0, 1])).
      to eq [[4, 6], [5, 6], [5, 7], [5, 8]]
  end

  it 'moves snake correctly downwards' do
    expect(move([[4, 5], [4, 6], [5, 6], [6, 6]], [0, -1])).
      to eq [[4, 6], [5, 6], [6, 6], [6, 5]]
  end

  it 'moves snake correctly to the right' do
    expect(move([[4, 5], [4, 6], [5, 6], [5, 7]], [1, 0])).
      to eq [[4, 6], [5, 6], [5, 7], [6, 7]]
  end

  it 'moves snake correctly to the left' do
    expect(move([[4, 5], [4, 6], [5, 6], [5, 7]], [-1, 0])).
      to eq [[4, 6], [5, 6], [5, 7], [4, 7]]
  end

  it 'does not change the snake input' do
    snake = [[4, 5], [4, 6], [5, 6], [5, 7]]
    direction = [0, 1]
    moved_snake = move(snake, direction)
    expect(snake).to eq [[4, 5], [4, 6], [5, 6], [5, 7]]
  end

  it 'does not change the direction input' do
    snake = [[4, 5], [4, 6], [5, 6], [5, 7]]
    direction = [0, 1]
    moved_snake = move(snake, direction)
    expect(direction).to eq [0, 1]
  end
end

describe '#grow' do
  it 'grows snake correctly upwards' do
    expect(grow([[4, 6], [5, 6], [5, 7]], [0, 1])).
      to eq [[4, 6], [5, 6], [5, 7], [5, 8]]
  end

  it 'grows snake correctly downwards' do
    expect(grow([[4, 6], [5, 6], [6, 6]], [0, -1])).
      to eq [[4, 6], [5, 6], [6, 6], [6, 5]]
  end

  it 'grows snake correctly to the right' do
    expect(grow([[4, 6], [5, 6], [5, 7]], [1, 0])).
      to eq [[4, 6], [5, 6], [5, 7], [6, 7]]
  end

  it 'grows snake correctly to the left' do
    expect(grow([[4, 6], [5, 6], [5, 7]], [-1, 0])).
      to eq [[4, 6], [5, 6], [5, 7], [4, 7]]
  end

  it 'does not change the snake input' do
    snake = [[4, 5], [4, 6], [5, 6], [5, 7]]
    direction = [0, 1]
    grown_snake = grow(snake, direction)
    expect(snake).to eq [[4, 5], [4, 6], [5, 6], [5, 7]]
  end

  it 'does not change the direction input' do
    snake = [[4, 5], [4, 6], [5, 6], [5, 7]]
    direction = [0, 1]
    grown_snake = grow(snake, direction)
    expect(direction).to eq [0, 1]
  end
end

describe '#snake?' do
  it 'returns true if there is snake on the given position' do
    expect(snake?([1, 2], [[0, 1], [1, 1], [1, 2], [1, 3]])).to eq true
  end
  it 'returns false if there is no snake on the given position' do
    expect(snake?([4, 5], [[0, 1], [1, 1], [1, 2], [1, 3]])).to eq false
  end
end

describe '#in_bounds?' do
  it 'returns true if the given position is in bounds at [0, 0]' do
    expect(in_bounds?([0, 0], {width: 10, height: 10})).to eq true
  end
  it 'returns true if the given position is in bounds at [w-1, h-1]' do
    expect(in_bounds?([9, 9], {width: 10, height: 10})).to eq true
  end
  it 'returns false if the given position is a wall' do
    expect(in_bounds?([-1, 10], {width: 10, height: 10})).to eq false
  end
  it 'returns false if the given position is a left wall' do
    expect(in_bounds?([-1, 5], {width: 10, height: 10})).to eq false
  end
  it 'returns false if the given position is a right wall' do
    expect(in_bounds?([10, 4], {width: 10, height: 10})).to eq false
  end
  it 'returns false if the given position is a top wall' do
    expect(in_bounds?([2, 10], {width: 10, height: 10})).to eq false
  end
  it 'returns false if the given position is a bottom wall' do
    expect(in_bounds?([2, -1], {width: 10, height: 10})).to eq false
  end
end

describe '#new_food' do
  it 'generates new food on the only free position' do
    expect(new_food([[0, 0]], [[0, 1], [1, 1]], {width: 2, height: 2})).
      to eq [1, 0]
  end
  it 'generates new food on a vacant and valid position' do
    food = [[0, 0], [2, 0]]
    snake = [[0, 1], [1, 1], [1, 2], [2, 2], [2, 1]]
    dimensions = {width: 3, height: 3}
    generated_food = new_food(food, snake, dimensions)
    expect(in_bounds?(generated_food, dimensions) &&
              !snake?(generated_food, snake)).to eq true
  end
end

# TODO: more tests with bigger field for #new_food

describe '#obstacle_ahead?' do
  it 'returns true if wall in front of snake' do
    expect(obstacle_ahead?([[3, 8], [3, 9]], [0, 1], {width: 10, height: 10})).
      to eq true
  end
  it 'returns true if position in front of snake is the snake' do
    expect(obstacle_ahead?([[3, 8], [3, 9], [2, 9], [2, 8]], [1, 0],
      {width: 10, height: 10})).to eq true
  end
  it 'returns false if position in front of snake is empty' do
    expect(obstacle_ahead?([[3, 8], [3, 9], [2, 9], [1, 9], [1, 8]], [0, -1],
      {width: 10, height: 10})).to eq false
  end
end

describe '#danger?' do
  it 'returns true if position in front of snake is a wall' do
    expect(danger?([[3, 8], [3, 9]], [0, 1], {width: 10, height: 10})).
    to eq true
  end
  it 'returns true if position two moves in front of snake is a wall' do
    expect(danger?([[3, 7], [3, 8]], [0, 1], {width: 10, height: 10})).
    to eq true
  end
  it 'returns true if position in front of snake is the snake' do
    expect(danger?([[3, 8], [3, 9], [2, 9], [2, 8]], [1, 0],
      {width: 10, height: 10})).to eq true
  end
  it 'returns true if position two moves in front of snake is the snake' do
    expect(danger?([[3, 8], [3, 9], [2, 9], [1, 9], [1, 8]], [1, 0],
      {width: 10, height: 10})).to eq true
  end
  it 'returns false if position one and two moves in front of snake is empty' do
    expect(danger?([[3, 8], [3, 9], [2, 9], [1, 9], [1, 8]], [0, -1],
      {width: 10, height: 10})).to eq false
  end
end
