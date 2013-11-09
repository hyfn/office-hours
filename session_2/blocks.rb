def yield_me
  yield
end

yield_me { puts "I'm in a block" }
# I'm in a block
# => nil

def yield_twice
  yield
  yield
end

yield_twice { puts "foo" }
# foo
# foo
# => nil

class Yielder

  def my_secret_thing
    :a_sekrit
  end

  def yield_something
    yield my_secret_thing
  end
end

Yielder.new.yield_something {|thing| puts thing }
# a_sekrit
# => nil
