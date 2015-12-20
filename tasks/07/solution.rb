module LazyMode
  def self.create_file(name, &block)
    file = File.new(name)
    file.instance_eval(&block)
    file
  end

  class Date
    attr_reader :year, :month, :day

    def initialize(date_string)
      @year, @month, @day = date_string.split('-').map(&:to_i)
    end

    def to_s
      "%{year}-%{month}-%{day}" % {
        year: @year.to_s.rjust(4, '0'),
        month: @month.to_s.rjust(2, '0'),
        day: @day.to_s.rjust(2, '0')
      }
    end

    def add_days(days)
      new_date = dup

      new_date.day += days

      new_date.month += (new_date.day - 1) / 30
      new_date.day = (new_date.day - 1) % 30 + 1

      new_date.year += (new_date.month - 1) / 12
      new_date.month = (new_date.month - 1) % 12 + 1

      new_date
    end

    def days
      @year * 12 * 30 + (@month - 1) * 30 + @day
    end

    def days_difference(other)
      (days - other.days).abs
    end
  end

  class File
    attr_reader :name, :notes

    def initialize(name)
      @name = name
      @notes = []
    end

    def note(header, *tags, &block)
      new_note = Note.new(@name, header, tags)
      new_note.file = self
      new_note.instance_eval(&block)

      notes << new_note
    end

    def daily_agenda(date)
      @notes.select { |note| note.scheduled_for_today?(date) }
    end

    def weekly_agenda(date)
      @notes.select { |note| note.scheduled_for_this_week?(date) }
    end
  end

  class Note
    attr_reader :header, :file_name, :tags
    attr_writer :file
    attr_accessor :body, :status

    def initialize(file_name, header, *tags)
      @file_name = file_name
      @header = header
      @tags = tags
    end

    def note(header, *tags, &block)
      file.note(header, *tags, &block)
    end

    def scheduled(date_string_with_repetition)
      date_string, repetition_string = date_string_with_repetition.split
      @date = Date(date_string)
      if repetition_string
        repeat_codes = {'m' => 30, 'w' => 7, 'd' => 1}
        repeat_every = repetition_string[1..-2].to_i
        @repeat_interval = repeat_every * repeat_codes[repetition_string[-1]]
      end
    end

    def scheduled_for_today?(date)
      # TODO: improve here
      if @repeat_interval
        @date.days_difference(date) % @repeat_interval == 0
      else
        @date == date
      end
    end

    def scheduled_for_this_week?(date)
      Array.new(7, date).zip(0..6).map(&:add_days).any?(&:scheduled_for_today)
    end
  end
end
