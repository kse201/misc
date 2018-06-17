require_relative '../bar'

p Bar.new.len('abcde')
p Bar.new.len([1,2,3,4,5,6])
p Bar.new.len(/regex/)
