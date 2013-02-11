#coding: UTF-8
class Stack
  def initialize(str)
    @content = str.split(" ").map{|v| v.to_i}
  end

  def pop
    @content.pop
  end

  def append(val)
    @content << val
  end

  def last
    @content.last
  end

  def manipulate(operation)
    arg1, arg2 = @content[-2], @content[-1]
    raise "На выполнение операции недосточно значений на стеке" if !arg1 or !arg2
    result = arg1.send(operation, arg2)
    self.pop
    self.pop
    self.append(result)
  end
end
