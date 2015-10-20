# Handle output of a word, keeping track of the output column
class WrappingOutput
  def initialize(line_length = 80, column = 0)
    @line_length = line_length
    @column = column
  end

  def print(*args)
    @output = *args
    Kernel.print(*args)
    update_column
  end

  private

  def update_column
    @column += output_length

    return if @column < @line_length - output_length

    puts
    @column = 0
  end

  # Calculate the length, ignoring escape sequences
  def output_length
    @output.each.reduce(0) do |acc, item|
      acc + ((/\A\e\[.*m\z/ =~ item) ? 0 : item.length)
    end
  end
end
