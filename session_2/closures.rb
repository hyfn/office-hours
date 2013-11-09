#######################
# Blocks are closures #
#######################
def yield_me
  yield
end

outside = :some_value
puts yield_me { outside }
# some_value
# => nil

outside = 42
puts yield_me { outside }
# 42
# => nil

callable = lambda { |inside| outside + inside }
callable.call(1)
# => 43

(1..3).map { |n| callable.call(n) }
# => [43, 44, 45]
