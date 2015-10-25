class Integer
  def prime?
    return false if self == 1
    divisor = 2
    square_root_of_number = Math.sqrt(self)
    while divisor <= square_root_of_number
      return false if self % divisor == 0
      divisor += 1
    end
    true
  end
end

class RationalSequence
  include Enumerable

  def initialize(n)
    @n = n
  end

  def each
    row = 1
    position = 1
    count = 0
    going_upward = false
    while count < @n
      numerator = position
      denominator = row + 1 - position
      numerator, denominator = denominator, numerator if going_upward
      irreducible = Rational(numerator, denominator)
      if irreducible.numerator == numerator
        yield irreducible
        count += 1
      end
      position += 1
      if position > row
        position = 1
        row += 1
        going_upward = !going_upward
      end
    end
  end
end

class PrimeSequence
  include Enumerable

  def initialize(n)
    @n = n
  end

  def each
    i = 0
    number = 2
    while i < @n
      if number.prime?
        yield number
        i += 1
      end
      number += 1
    end
  end
end

class FibonacciSequence
  include Enumerable

  def initialize(n, first: 1, second: 1)
    @n = n
    @first = first
    @second = second
  end

  def each
    a = @first
    b = @second
    i = 0
    while i < @n
      yield a
      a, b = b, a + b
      i += 1
    end
  end
end

module DrunkenMathematician
  module_function

  def meaningless(n)
    first_rational_numbers = RationalSequence.new(n)
    two_groups = first_rational_numbers.
      group_by { |number| number.numerator.prime? || number.denominator.prime? }
    two_groups.map { |key, group| two_groups[key] = group.reduce(1, :*) }
    two_groups.fetch(true, 1) / two_groups.fetch(false, 1)
  end

  def aimless(n)
    first_n_prime_numbers = PrimeSequence.new(n)
    rational_numbers = []
    first_n_prime_numbers.each_slice(2) do |group|
      rational_numbers << Rational(group.fetch(0, 0), group.fetch(1, 1))
    end
    rational_numbers.reduce(0, :+)
  end

  def worthless(n)
    rational_numbers = RationalSequence.new(Float::INFINITY)
    taken_numbers = []
    rational_numbers.take_while do |number|
      taken_numbers << number
      taken_numbers.reduce(0, :+) <= n
    end
  end
end
