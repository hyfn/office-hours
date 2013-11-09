# EvalWizarrrrd wants more power, y'all.
class EvalWizarrrd
  attr_reader :level
  def initialize
    @level = 1
  end

  # Level up. You can't level down.
  def level_up!
    @level += 1
  end

  def spell name, &blk
    spell = Spell.new(name)
    spell.instance_eval(&blk) if block_given?
    spell
  end

  # Our custom spell changed.
  def lightning_bolt(tgt)
    # What the hell is this, Javascript?
    _self = self
    spell("Lighting Bolt!!! ZAPP!!!") do
      target tgt
      damage do
        # We want dynamic damage, based on the EvalWizarrrrd#level.
        # Problem is, `instance_eval` up there has flattened.
        # That's why we need to stash `self` in `_self`, which is
        # enclosed by this block.
        100 + rand(111) * (_self.level * 0.827)
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

    # Make damage a little more dynamic.
    # If a block is passed, save it as
    # a Proc; otherwise, make one with
    # the flat +dmg+ amount
    def damage dmg = nil, &blk
      @damage = blk || Proc.new { dmg }
    end

    def cast
      return "#{@name} Missed!" unless @target
      "Hit #{@target} with #{@name} for #{@damage.call} damage!!!"
    end
  end
end

ew = EvalWizarrrd.new
# => #<EvalWizarrrd:0x007fb2e3814d70>

spell = ew.lightning_bolt("Matt Otto")

# It's different every time!
3.times { puts spell.cast }
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 137.215 damage!!!
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 162.025 damage!!!
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 160.37099999999998 damage!!!

# What if the wizarrrd levels up?
ew.level_up!
3.times { puts spell.cast }
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 230.666 damage!!!
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 219.088 damage!!!
# Hit Matt Otto with Lighting Bolt!!! ZAPP!!! for 134.73399999999998 damage!!!

