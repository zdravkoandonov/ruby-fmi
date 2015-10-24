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

  end

  def aimless(n)

  end

  def worthless(n)

  end
end
