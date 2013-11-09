require 'pry'
module Magic

  # We need more flexibility.
  def spell name, &blk
    define_method(name) do |tgt|
      spell = Spell.new(name)
      spell.target tgt

      # OK, here's where the magic starts.
      # If the new method gets a block,
      if blk
        # we check to see how many arguments
        # were passed to the block.
        if blk.arity > 0
          # If there are any, yield `self`, which
          # is the current instance, sharing its
          # scope. 
          yield self, spell
        else
          # Otherwise, revert to the old DSL behavior.
          spell.instance_eval &blk
        end
      end

      spell
    end
  end

  class Spell
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def target tgt
      @target = tgt
    end

    def damage dmg = nil, &blk
      @damage = blk || lambda { dmg }
    end

    def cast
      return "#{@name} Missed!" unless @target
      "Hit #{@target} with #{@name} for #{@damage.call} damage!!!"
    end
  end
end

class EvalWizarrrd
  extend Magic
  attr_reader :level
  def initialize
    @level = 1
  end

  def level_up!
    @level += 1
  end

  # I want my dynamic damage back!
  # Whenever the spell is cast, we get
  # access to both the wizard and the spell
  spell :lightning_bolt do |wizarrrd, sp|
    sp.damage do
      100 + (rand(111) * (wizarrrd.level * 0.827))
    end
  end

end


ew = EvalWizarrrd.new

spell = ew.lightning_bolt("Atta Mott")
puts spell.cast
# => Hit Atta Mott with lightning_bolt for 147.139 damage!!!

ew.level_up!
puts spell.cast
# => Hit Atta Mott with lightning_bolt for 278.632 damage!!!
