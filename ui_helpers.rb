class LCDYesNo
  def initialize(screen, input, question)
    @screen = screen
    @input = input
    @question = question
  end
  
  def get_answer
    answer = false
    while(true) do
      @screen.clear
      @screen.write "#{@question}\n#{answer ? 'Yes' : 'No'}", :important
      button = @input.wait_for_button
      case button
        when :next, :prev
          answer = !answer
        when :select
          return answer
      end
    end
  end
end

class LCDAdjustTime
  def initialize(screen, input, label, value, adjust_by)
    @screen = screen
    @input = input
    @label = label
    @value = value
    @adjust_by = adjust_by
  end
  
  def get_value
    while(true) do
      @screen.clear
      @screen.write "#{@label}\n#{secs_to_ms(@value)}", :important
      button = @input.wait_for_button
      case button
        when :previous
          @value -= @adjust_by
        when :next
          @value += @adjust_by
        when :select
          return @value
      end
    end
  end
end

class LCDMenu
  def initialize(screen, input, label, items)
    @screen = screen
    @input = input
    @items = items
    @label = label
  end
  
  def get_selection
    selected_idx = 0

    @screen.clear
    @screen.write "Select #{@label}\n#{@items[selected_idx].ljust(16, " ")}", :important
    while true do
      button = @input.wait_for_button
      case button
        when :next
          selected_idx += 1
          selected_idx = 0 if selected_idx > @items.length-1
          @screen.write "Select #{@label}\n#{@items[selected_idx].ljust(16, " ")}", :important
        when :previous
          selected_idx -= 1
          selected_idx = @items.length-1 if selected_idx < 0
          @screen.write "Select #{@label}\n#{@items[selected_idx].ljust(16, " ")}", :important
        when :select
          return @items[selected_idx]
      end
    end
  end
end
