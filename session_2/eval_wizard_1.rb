class LameWizard
  def lame_spell
    "This is lame"
  end
end

# LameWizard is lame.
LameWizard.new.lame_spell
# => "This is lame"

# EvalWizarrrd can make up any spell he wants.
# EvalWizarrrd don't care.
class EvalWizarrrd

  # create a new Spell; if a block is passed,
  # evaluate the block in the context of the 
  # new Spell. 
  def spell name, &blk
    spell = Spell.new(name)
    spell.instance_eval(&blk) if block_given?
    spell
  end

  # Use our #spell method to create a custom
  # spell. Since the block's `self` is an instance
  # of Spell, this is a baby DSL.
  def lightning_bolt(tgt)
    spell "Lighting Bolt!!! ZAPP!!!" do
      # Blocks are closures! Even though this block's 
      # `self` is a Spell, we can pass a +tgt+ in from
      # the outside.
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

    # I normally don't recommend using instance variables
    # this way, but it's necessary if we want to use the
    # method as a setter.
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

# No target! You missed.
spell.cast
# => "Flaccid Fireball Missed!"


# Let's try that again; this time, we'll give the spell
# some damage, and a target.
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
