module Magic
  def spell name, &blk
    spell = Spell.new(name)
    yield spell if block_given?
    spell
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
  include Magic
  attr_reader :level
  def initialize
    @level = 1
  end

  def level_up!
    @level += 1
  end


  def lightning_bolt(tgt)
    spell("Lighting Bolt!!! ZAPP!!!") do |sp|
      sp.target tgt
      sp.damage do
        rand(111) + ((level * 1.085) * 35)
      end
    end
  end

end

ew = EvalWizarrrd.new
# => #<EvalWizarrrd:0x007fb2e3814d70>

# ew.lightning_bolt("Matt Otto").cast
# NameError: undefined local variable or method `level' for #<EvalWizarrrd::Spell:0x007fdadc018790>
