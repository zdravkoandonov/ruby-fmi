module TurtleGraphics
  class Canvas
    def self.max_intensity(canvas)
      canvas.map { |row| row.max }.max
    end

    class ASCII
      def initialize(characters)
        @characters = characters
      end

      def build(canvas)
        max_intensity = Canvas.max_intensity(canvas)
        ascii_rows = canvas.map do |row|
          row_of_characters = row.map do |cell|
            @characters[((@characters.size - 1) * cell / max_intensity.to_f).ceil]
          end
          row_of_characters.join
        end
        ascii_rows.join("\n")
      end
    end

    class HTML
      def initialize(pixel_size)
        @pixel_size = pixel_size
        @html_string_beginning = "<!DOCTYPE html>
<html>
<head>
  <title>Turtle graphics</title>

  <style>
    table {
      border-spacing: 0;
    }

    tr {
      padding: 0;
    }

    td {
      width: 5px;
      height: 5px;

      background-color: black;
      padding: 0;
    }
  </style>
</head>
<body>
  <table>"
        @html_string_table = ""
        @html_string_ending = "</table>
</body>
</html>"
        puts @html_string
      end

      def build(canvas)
        max_intensity = Canvas.max_intensity(canvas)
        # TODO: use map?
        canvas.each do |row|
          @html_string_table << '<tr>'
          row.each do |pixel|
            @html_string_table << '<td style="opacity: '
            @html_string_table << format('%.2f', pixel.to_f / max_intensity)
            @html_string_table << '"></td>'
          end
          @html_string_table << '</tr>'
        end
        @html_string_beginning + @html_string_table + @html_string_ending
      end
    end
  end

  class Turtle
    ORIENTATIONS = {left: [0, -1], up: [-1, 0], right: [0, 1], down: [1, 0]}

    # TODO: check rows/columns -> x/y matching
    def initialize(rows, columns)
      @rows = rows
      @columns = columns
      @turtle = [0, 0]
      @direction = ORIENTATIONS[:right]
      @canvas = Array.new(rows) { Array.new(columns, 0) }
    end

    def draw(output = nil)
      @canvas[@turtle[1]][@turtle[0]] += 1
      self.instance_eval(&Proc.new)
      if (output)
        output.build(@canvas)
      else
        @canvas
      end
    end

    def move
      # TODO: fix ugliness
      @turtle[0] = (@turtle[0] + @direction[0])
      @turtle[0] = 0 unless @turtle[0].between?(0, @rows - 1)
      @turtle[1] = (@turtle[1] + @direction[1])
      @turtle[1] = 0 unless @turtle[1].between?(0, @columns - 1)
      @canvas[@turtle[0]][@turtle[1]] += 1
    end

    def turn_left
      @direction = [-@direction[1], @direction[0]]
    end

    def turn_right
      # TODO: fix skeptic -
      @direction = [@direction[1], - @direction[0]]
    end

    def spawn_at(row, column)
      @canvas[@turtle[0]][@turtle[1]] -= 1
      @turtle = [row, column]
      @canvas[@turtle[0]][@turtle[1]] += 1
    end

    def look(orientation)
      @direction = ORIENTATIONS[orientation]
    end
  end
end

# canvas = TurtleGraphics::Canvas::HTML.new(1)
# html = TurtleGraphics::Turtle.new(400, 400).draw(canvas) do
#   spawn_at 200, 200

#   step = 0

#   28300.times do
#     is_left = (((step & -step) << 1) & step) != 0

#     if is_left
#       turn_left
#     else
#       turn_right
#     end
#     step += 1

#     move
#   end
# end

# File.write('dragon.html', html)
