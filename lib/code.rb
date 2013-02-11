#coding: UTF-8
class Code
  def initialize(code_str)
    @code = code_str.gsub(" ", "").split("\n")
    @current_row = 0
    check_code_is_valid
  end

  def go_to(row)
    @current_row = row
  end
  def next
    @current_row += 1
  end

  def previous
    @current_row -= 1
  end

  def execute_row
    result = {:arith_operation => @code[@current_row]} if is_arith_operation?(@code[@current_row])
    result = {:put_val => current_row_attr} if is_put_val?(@code[@current_row])
    result = :del if is_del?(@code[@current_row])
    result = :program_end if is_program_end?(@code[@current_row])
    result = {:write_from_cell => current_row_attr} if is_write_from_cell?(@code[@current_row])
    result = {:write_to_cell => current_row_attr} if is_write_to_cell?(@code[@current_row])
    result = {:go_to => current_row_attr} if is_go_to?(@code[@current_row])
    result = {:go_to_if_0 => current_row_attr} if is_go_to_if_0?(@code[@current_row])
    result = {:go_to_if_less => current_row_attr} if is_go_to_if_less?(@code[@current_row])
    return result
  end


  private

  def current_row_attr
    @code[@current_row].match(/\d+/).to_s.to_i
  end
  def check_code_is_valid
    @code.each_with_index do |code_row, index|
      raise "Синтаксическая ошибка в строке №#{index}"unless is_valid?(code_row)
    end
  end

  def is_valid?(code_row)
    is_arith_operation?(code_row) ||
    is_put_val?(code_row) ||
    is_del?(code_row) ||
    is_program_end?(code_row) ||
    is_write_from_cell?(code_row) ||
    is_write_to_cell?(code_row) ||
    is_go_to?(code_row) ||
    is_go_to_if_0?(code_row) ||
    is_go_to_if_less?(code_row)
  end

  def is_put_val?(code_row)
    code_row.match(/(^\d+$)/)
  end

  def is_del?(code_row)
    code_row.match(/(^\^$)/)
  end

  def is_program_end?(code_row)
    code_row.match(/(^\.$)/)
  end

  def is_arith_operation?(code_row)
    code_row.match(/(^\+$)/) || code_row.match(/(^\-$)/) || code_row.match(/(^\*$)/) || code_row.match(/(^\/$)/)
  end

  def is_write_to_cell?(code_row)
    code_row.match(/(^\>\#[0-3]$)/)
  end

  def is_write_from_cell?(code_row)
    code_row.match(/(^\#[0-3]+$)/)
  end

  def is_go_to?(code_row)
    code_row.match(/(^\d+\:$)/)
  end

  def is_go_to_if_0?(code_row)
    code_row.match(/(^\d+\:0$)/)
  end

  def is_go_to_if_less?(code_row)
    code_row.match(/(^\d+\:\<$)/)
  end

end
