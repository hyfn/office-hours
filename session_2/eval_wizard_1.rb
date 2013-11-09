class LameWizard
  def lame_spell
    "This is lame"
  end
end

class EvalWizarrrd
  def spell name, &blk
    spell = Spell.new(name)
    spell.instance_eval(&blk) if block_given?
    spell
  end

  def lightning_bolt(tgt)
    spell "Lighting Bolt!!! ZAPP!!!" do
      target tgt
      damage 111
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

    def damage dmg
      @damage = dmg
    end

    def cast
      return "#{@name} Missed!" unless @target
      "Hit #{@target} with #{@name} for #{@damage} damage!!!"
    end
  end
end

ew = EvalWizarrrd.new
# => #<EvalWizarrrd:0x007fb2e3814d70>

spell = ew.spell("Flaccid Fireball")
# => #<EvalWizarrrd::Spell:0x007fb2e22b28b0 @name="Flaccid Fireball">

spell.cast
# => "Flaccid Fireball Missed!"

better_spell = ew.spell("Meatier, Sturdier Fireballs") do
  target "Matt Otto"  
  damage 42  
end
# => #<EvalWizarrrd::Spell:0x007fb1920bbfa8
#  @damage=42,
#  @name="Meatier, Sturdier Fireballs",
#  @target="Matt Otto">

better_spell.cast
# => "Hit Matt Otto with Meatier, Sturdier Fireballs for 42 damage!!!"

ew.lightning_bolt("Matt Otto").cast 
# => "Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 111 damage!!!"
