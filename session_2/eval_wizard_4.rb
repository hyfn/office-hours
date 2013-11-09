module Magic
  
  def spell name
    define_method name do |tgt, &blk|
      spell = Spell.new(name)
      spell.target tgt
      spell.instance_eval &blk if blk
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

  spell :lightning_bolt do |sp|
    sp.damage 111
  end

end
