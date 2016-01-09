class Spreadsheet
  class Error < RuntimeError
  end

  def initialize(data_string = "")
    @table = data_string.strip.split("\n")
      .map { |row_string| row_string.strip.split(/\t| {2,}/) }
  end

  def empty?
    @table.empty?
  end

  def cell_at(cell_index)
    cell_index.match(/\A(?<column>[[:upper:]]+)(?<row>\d+)\Z/) do |match|
      row, column = match["row"].to_i - 1, column_to_index(match["column"])
      if row > @table.size or column > @table[0].size
        raise Error, "Cell '#{cell_index}' does not exist"
      else
        return @table[row][column]
      end
    end

    raise Error, "Invalid cell index '#{cell_index}'"
  end

  def [](cell_index)
    cell_string = cell_at(cell_index)
    evaluate(cell_string)
  end

  def to_s
    @table.map { |row| row.map { |data| evaluate(data) }.join("\t") }.join("\n")
  end

  private

  def column_to_index(column_string)
    addends = column_string.each_char.map.with_index do |char, index|
      (char.ord - 'A'.ord + 1) * 26**(column_string.size - index - 1)
    end
    addends.reduce(:+) - 1
  end

  def evaluate(cell_string)
    if cell_string[0] == '='
      Expression.new(cell_string[1..-1].lstrip, self).value
    else
      cell_string
    end
  end

  class Functions
    class << self
      def add(*arguments)
        p arguments
        arguments.reduce(:+)
      end

      # MULTIPLY – приема два или повече аргумента и връща произведението им.
      def multiply(*arguments)
        arguments.reduce(:*)
      end

      # SUBTRACT – приема точно два аргумента и връща разликата на първия минус
      # втория.
      def subtract(first_argument, second_argument)
        first_argument - second_argument
      end

      # DIVIDE – приема точно два аргумента, разделя първия на втория и връща
      # резултата.
      def divide(first_argument, second_argument)
        first_argument / second_argument
      end

      # MOD – приема точно два аргумента и връща остатъка от делението на
      # първия аргумент на втория (аналогично на "оператора" % в Ruby).
      def mod(first_argument, second_argument)
        first_argument % second_argument
      end
    end
  end

  class Expression
    ARGUMENT = /((\d+(\.\d+)?)|([[:upper:]]+\d+))/
    FUNCTION = /[[:upper:]]+\((#{ARGUMENT}\s*,\s*)+#{ARGUMENT}\)/

    attr_accessor :value

    def initialize(expression_string, spreadsheet)
      @expression_string = expression_string
      @spreadsheet = spreadsheet
      @value = calculate_expression(expression_string)
    end

    private

    def calculate_expression(expression)
      if /\A#{ARGUMENT}\Z/ =~ expression
        calculate_argument(expression)
      elsif /\A#{FUNCTION}\Z/ =~ expression
        calculate_valid_function_from_string(expression)
      else
        raise "Trololo"
      end
    end

    def calculate_argument(expression)
      if expression =~ /\A\d/
        expression.to_f.to_s
      else
        @spreadsheet[expression]
      end
    end

    def calculate_valid_function_from_string(expression)
      function = /(?<name>[[:upper:]]+)\((?<arguments>.+)\)/.match(expression)
      calculate_function(function[:name], function[:arguments])
    end

    def calculate_function(function_name, arguments_string)
      arguments = arguments_string.split(/\s*,\s*/)
        .map { |argument| format_number(calculate_argument(argument).to_f) }
      Functions.public_send(function_name.downcase.to_sym, *arguments).to_s
    rescue Exception => e
      # TODO: find out which exception is which
      puts e.backtrace
    end

    def whole_number?(float)
      float.to_i == float
    end

    def format_number(float)
      if whole_number?(float)
        float.to_i
      else
        float.round(2)
      end
    end
  end
end
