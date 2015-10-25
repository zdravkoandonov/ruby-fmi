describe 'Third task' do
  describe RationalSequence do
    it 'returns empty array for the zero-th rational number' do
      expect(RationalSequence.new(0).to_a).to eq []
    end
    it 'can calculate the first rational number' do
      expect(RationalSequence.new(1).to_a).to eq ['1/1'.to_r]
    end
    it 'can calculate the first five rational numbers' do
      expect(RationalSequence.new(5).to_a).
        to eq ['1/1'.to_r, '2/1'.to_r, '1/2'.to_r, '1/3'.to_r, '3/1'.to_r]
    end
    it 'can calculate the first twenty rational numbers' do
      expect(RationalSequence.new(20).to_a).
        to eq ['1/1'.to_r, '2/1'.to_r, '1/2'.to_r, '1/3'.to_r, '3/1'.to_r,
               '4/1'.to_r, '3/2'.to_r, '2/3'.to_r, '1/4'.to_r, '1/5'.to_r,
               '5/1'.to_r, '6/1'.to_r, '5/2'.to_r, '4/3'.to_r, '3/4'.to_r,
               '2/5'.to_r, '1/6'.to_r, '1/7'.to_r, '3/5'.to_r, '5/3'.to_r]
    end
  end

  describe FibonacciSequence do
    it 'return empty array for the zero-th Fibonacci number' do
      expect(FibonacciSequence.new(0).to_a).to eq []
    end
    it 'can calculate the first Fibonacci number' do
      expect(FibonacciSequence.new(1).to_a).to eq [1]
    end
    it 'can calculate the first five Fibonacci numbers' do
      expect(FibonacciSequence.new(5).to_a).to eq [1, 1, 2, 3, 5]
    end
    it 'can calculate the first Fibonacci number starting with 0 1' do
      expect(FibonacciSequence.new(1, first: 0, second: 1).to_a).to eq [0]
    end
    it 'can calculate the first five Fibonacci numbers starting with 0 1' do
      expect(FibonacciSequence.new(5, first: 0, second: 1).to_a).to eq [0, 1, 1, 2, 3]
    end
  end

  describe PrimeSequence do
    it 'returns empty array for the zero-th number' do
      expect(PrimeSequence.new(0).to_a).to eq []
    end
    it 'can calculate the first prime (and it is not Optimus)' do
      expect(PrimeSequence.new(1).to_a).to eq [2]
    end
      it 'can calculate the first five primes' do
        expect(PrimeSequence.new(5).to_a).to eq [2, 3, 5, 7, 11]
      end
  end

  describe DrunkenMathematician do
    it 'is drunk' do
      expect(->_{_%_}["->_{_%%_}[%p]"]).to eq '->_{_%_}["->_{_%%_}[%p]"]'
    end

    describe '#meaningless' do
      it 'can calculate for 0' do
        expect(DrunkenMathematician.meaningless(1)).to eq 1
      end
      it 'can calculate for 1' do
        expect(DrunkenMathematician.meaningless(1)).to eq Rational(1, 1)
      end
      it 'can calculate for 6' do
        expect(DrunkenMathematician.meaningless(6)).to eq Rational(1, 4)
      end
    end

    describe '#aimless' do
      it 'can calculate for 0' do
        expect(DrunkenMathematician.aimless(0)).to eq 0
      end
      it 'can calculate for 1' do
        expect(DrunkenMathematician.aimless(1)).to eq 2
      end
      it 'can calculate for 2' do
        expect(DrunkenMathematician.aimless(2)).to eq '2/3'.to_r
      end
      it 'can calculate for 3' do
        expect(DrunkenMathematician.aimless(3)).to eq '17/3'.to_r
      end
      it 'can calculate for 4' do
        expect(DrunkenMathematician.aimless(4)).to eq '29/21'.to_r
      end
    end

    describe '#worthless' do
      it 'can calculate for 0' do
        expect(DrunkenMathematician.worthless(0)).to eq []
      end
      it 'can calculate for 1' do
        expect(DrunkenMathematician.worthless(1)).to eq %w(1/1).map(&:to_r)
      end
      it 'can calculate for 5' do
        expect(DrunkenMathematician.worthless(5)).to eq ['1/1'.to_r, '2/1'.to_r, '1/2'.to_r, '1/3'.to_r]
      end
    end
  end
end
