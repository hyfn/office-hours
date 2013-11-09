class EvalWizarrrd
  attr_reader :level
  def initialize
    @level = 1
  end

  def level_up!
    @level += 1
  end

  def spell name, &blk
    spell = Spell.new(name)
    spell.instance_eval(&blk) if block_given?
    spell
  end

  def lightning_bolt(tgt)
    _self = self
    spell("Lighting Bolt!!! ZAPP!!!") do
      target tgt
      damage do
        rand(111) + ((_self.level * 1.085) * 35)
        # rand(111)
      end
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

ew = EvalWizarrrd.new
# => #<EvalWizarrrd:0x007fb2e3814d70>

# ew.lightning_bolt("Matt Otto").cast
# NameError: undefined local variable or method `level' for #<EvalWizarrrd::Spell:0x007fdadc018790>
