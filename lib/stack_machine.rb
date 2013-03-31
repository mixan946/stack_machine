#coding: UTF-8
$LOAD_PATH << './'
require 'code'
require 'stack'

class StackMachine
  def initialize(stack_str, code)
    @stack = Stack.new(stack_str)
    @cells = Array.new(4)
    @code = Code.new(code)
    @stop = false
    run
  end

  def run
    return puts "Результат: #{@stack.last}" if @stop
    if @code.execute_row.is_a?(Hash)
      send(@code.execute_row.keys.first, @code.execute_row.values.first)
      @code.next
    else
      send(@code.execute_row)
      @code.next
    end
    run
  end

  def write_to_cell(num)
    @cells[num] = @stack.last
  end

  def write_from_cell(num)
    @stack.append(@cells[num])
  end

  private
  def arith_operation(opr)
    @stack.manipulate(opr)
  end
  def put_val(val)
    @stack.append(val)
  end
  def del
    @stack.pop
  end
  def program_end
    @stop = true
  end
  def write_from_cell(num)
    @stack.append(@cells[num])
  end
  def write_to_cell(num)
    @cells[num] = @stack.last
  end
  def go_to(num)
    @code.go_to(num - 1)
  end
  def go_to_if_0(num)
    @code.go_to(num - 1) if @stack.last == 0
  end
  def go_to_if_less(num)
    @code.go_to(num - 1) if @stack.last < 0
  end
end

