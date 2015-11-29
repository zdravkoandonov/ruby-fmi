describe 'TurtleGraphics' do
  describe 'Turtle' do
    describe '#draw' do
      context 'No special canvas' do
        describe '#move' do
          it 'marks where the turtle has moved' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw { move }
            expect(canvas).to eq [[1, 1], [0, 0]]
          end

          it 'spawns the turtle at the beginning of the current row' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              move
              move
            end

            expect(canvas).to eq [[2, 1], [0, 0]]
          end

          it 'spawns the turtle at the beginning of the current column' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              turn_right
              move
              move
            end

            expect(canvas).to eq [[2, 0], [1, 0]]
          end
        end

        describe '#turn_right' do
          it 'turns the orienation of the turtle right of where we stand' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              turn_right
              move
            end

            expect(canvas).to eq [[1, 0], [1, 0]]
          end
        end

        describe '#turn_left' do
          it 'turns the orienation of the turtle left of where we stand' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              turn_left
              move
            end

            expect(canvas).to eq [[2, 0], [0, 0]]
          end
        end

        describe '#spawn_at' do
          it 'sets the start position of the turtle and marks it' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw { spawn_at(1, 0) }
            expect(canvas).to eq [[0, 0], [1, 0]]
          end

          it 'does not change the orientation of the turtle' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              spawn_at(1, 0)
              move
            end

            expect(canvas).to eq [[0, 0], [1, 1]]
          end
        end

        describe '#look' do
          it 'sets the orientation of the turtle' do
            canvas = TurtleGraphics::Turtle.new(2, 2).draw do
              look(:down)
              move
            end

            expect(canvas).to eq [[1, 0], [1, 0]]
          end
        end
      end

      context 'Canvas is Canvas::ASCII' do
        context 'three characters' do
          let(:ascii_canvas) { TurtleGraphics::Canvas::ASCII.new([' ', '-', '=']) }

          it 'draws correctly canvas with no movement' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do

            end

            expect(ascii).to eq "= \n  "
          end

          it 'draws correctly with one intensity' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              turn_right
              move
            end

            expect(ascii).to eq "==\n=="
          end

          it 'draws correctly with two intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
            end

            expect(ascii).to eq "==\n ="
          end

          it 'draws correctly with three intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              2.times { turn_right }
              move
              turn_left
              move
              turn_left
              move
              2.times { turn_right }
              move
            end

            expect(ascii).to eq "==\n--"
          end

          it 'draws correctly with four intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              2.times { turn_right }
              move
              turn_left
              move
              2.times { turn_right }
              move
            end

            expect(ascii).to eq "==\n -"
          end

          it 'draws correctly with five intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 6).draw(ascii_canvas) do
              5.times { move }
              2.times { turn_left }
              4.times { move }
              2.times { turn_left }
              3.times { move }
              2.times { turn_left }
              2.times { move }
            end

            expect(ascii).to eq "--===-\n      "
          end
        end

        context 'four characters' do
          let(:ascii_canvas) { TurtleGraphics::Canvas::ASCII.new([' ', '-', '=', '#']) }

          it 'draws correctly canvas with no movement' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do

            end

            expect(ascii).to eq "# \n  "
          end

          it 'draws correctly with one intensity' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              turn_right
              move
            end

            expect(ascii).to eq "##\n##"
          end

          it 'draws correctly with two intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
            end

            expect(ascii).to eq "##\n #"
          end

          it 'draws correctly with three intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              2.times { turn_right }
              move
              turn_left
              move
              turn_left
              move
              2.times { turn_right }
              move
            end

            expect(ascii).to eq "#=\n--"
          end

          it 'draws correctly with four intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 2).draw(ascii_canvas) do
              move
              turn_right
              move
              2.times { turn_right }
              move
              turn_left
              move
              2.times { turn_right }
              move
            end

            expect(ascii).to eq "=#\n -"
          end

          it 'draws correctly with five intensities' do
            ascii = TurtleGraphics::Turtle.new(2, 6).draw(ascii_canvas) do
              5.times { move }
              2.times { turn_left }
              4.times { move }
              2.times { turn_left }
              3.times { move }
              2.times { turn_left }
              2.times { move }
            end

            expect(ascii).to eq "-=###-\n      "
          end
        end
      end

      context 'Canvas is Canvas::HTML' do

      end
    end
  end

#  describe 'Canvas::HTML' do
#    it 'sets the pixel size of the table' do
#      html_canvas = TurtleGraphics::Canvas::HTML.new(3)
#      canvas = TurtleGraphics::Turtle.new(2, 2).draw(html_canvas) { move }
#      expect(canvas.gsub(/\s+/, '')).to include <<-HTML.gsub(/\s+/, '')
#td {
#  width: 3px;
#  height: 3px;
#      HTML
#    end
#  end
end
