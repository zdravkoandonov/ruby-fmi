def button_presses(message)
  downcase_message = message.downcase
  buttons = %w[1 abc2 def3 ghi4 jkl5 mno6 pqrs7 tuv8 wxyz9 * \ 0 #]
  symbols_grouped_by_presses = ["", "", "", "", ""]
  buttons.each { |button| button.each_char.with_index { |symbol, presses_count| symbols_grouped_by_presses[presses_count] << symbol } }
  total_presses = 0
  downcase_message.each_char { |symbol| total_presses += 1 + symbols_grouped_by_presses.index { |symbols_group| symbols_group.include?(symbol) } }
  total_presses
end
