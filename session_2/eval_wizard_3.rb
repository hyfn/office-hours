module Magic

  # Now `spell` creates new methods!
  def spell name, &blk
    # Create a new instance method that encapsulates
    # the previous behavior, with a nicer DSL.
    define_method(name) do |tgt|
      spell = Spell.new(name)
      spell.target tgt
      spell.instance_eval &blk if blk
      # yield spell if block_given?
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

  # We just converted `spell` into a class method!
  # Now EvalWizarrrd can describe the spells its
  # instances can cast.
  # I'd say this combines a "class macro" and a DSL:
  spell :lightning_bolt do
    damage 111
  end

end


ew = EvalWizarrrd.new

puts ew.lightning_bolt("Atta Mott").cast
# => Hit Atta Mott with lightning_bolt for 111 damage!!!
