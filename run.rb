#coding: UTF-8
$LOAD_PATH << './lib'
require 'stack_machine'
puts 'Введите стек'
StackMachine.new(gets, File.open('code.stmach').read)
