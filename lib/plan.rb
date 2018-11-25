require "tsort"
require "set"

class GraphHash < Hash
  include TSort

  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    fetch(node).each(&block) rescue nil
  end
end

class Condition
  attr_reader :name, :property

  def initialize(name, property)
    @name = name
    @property = property
  end

  def ==(value)
    value.name == name && value.property == property
  end

  def to_s
    "condition(#{@name}: #{@property})"
  end
end

class Action
  attr_reader :name, :preconditions, :add_effects, :del_effects

  def initialize(name, preconditions, add_effects, del_effects)
    @name = name
    @preconditions = preconditions
    @add_effects = add_effects
    @del_effects = del_effects
  end

  def process(world_state)
    state = world_state.dup

    @preconditions.each do |precondition|
      return false unless state.include?(precondition)
    end

    @del_effects.each do |del|
      state.delete(del)
    end

    @add_effects.each do |add|
      state << add
    end

    state
  end

  def ==(value)
    name == value.name && preconditions.count == value.preconditions.count
  end

  def to_s
    "#{name}(#{preconditions})"
  end
end

# Invariant: before < after
class OrderingConstraint
  attr_reader :before, :after

  def initialize(before, after)
    @before = before
    @after = after
  end
end

class CausalLink
  attr_reader :from, :to, :provides

  def initialize(from, to, provides)
    @from = from
    @to = to
    @provides = provides
  end
end

class Timeout < StandardError; end
class Unsolveable < StandardError; end

class Plan
  def initialize(start, goals)
    @start = Action.new(:start, [], start, [])
    @goal = Action.new(:goal, goals, [], [])
    @ordering_constraints = [OrderingConstraint.new(@start, @goal)]
    @causal_links = []
    @agenda = []

    goals.each do |goal|
      @agenda << [@goal, goal] unless start.include?(goal)
    end
  end

  def find_open_precondition
    @agenda.sample
  end

  def solution?
    @agenda.empty?
  end

  def introduces_cycle?(next_constraint)
    next_constraints = @ordering_constraints.concat([next_constraint])

    dependencies = {}
    next_constraints.each do |constraint|
      unless dependencies.key?(constraint.after.name)
        dependencies[constraint.after.name] = []
      end
      dependencies[constraint.after.name] << constraint.before.name
    end

    path = Set.new

    visit = lambda do |node|
      path.add(node)
      dependencies.fetch(node, []).each do |child_node|
        return true if path.member?(child_node) or visit.call(child_node)
      end
      path.delete(node)
      false
    end

    dependencies.keys.any? do |node|
      visit.call(node)
    end
  end

  def add_constraint(constraint)
    @ordering_constraints << constraint unless introduces_cycle?(constraint)
  end

  def generate(actions)
    tries = 0

    while !solution?
      tries += 1

      subgoal = find_open_precondition
      to = subgoal.first
      predicate = subgoal.last

      from = actions.find do |action|
        result = action.add_effects.include?(predicate)
      end

      unless from
        # If no positive propositions are found, check negative propositions
        # TODO: rewrite this in terms of evaluating logical expressions
        from = actions.find do |action|
          action.del_effects.include?(predicate)
        end
      end

      raise Unsolveable.new unless from

      @causal_links << CausalLink.new(from, to, predicate)
      @ordering_constraints << OrderingConstraint.new(from, @goal)
      @ordering_constraints << OrderingConstraint.new(@start, from)

      unless to == @goal
        add_constraint(OrderingConstraint.new(from, to))
      end

      from.preconditions.each do |pre|
        if @start.add_effects.include?(pre)
          @causal_links << CausalLink.new(@start, from, pre)
        else
          @agenda << [from, pre]
        end
      end

      @agenda.delete(subgoal)

      @causal_links.each do |link|
        if from.del_effects.include?(link.provides) && link.to != from
          add_constraint(OrderingConstraint.new(link.to, from))
        end
      end

      raise Timeout.new if tries > 200
    end

    flatten_plan(@ordering_constraints)
  end

  def flatten_plan(constraints)
    dependencies = GraphHash.new
    constraints.shuffle.each do |constraint|
      unless dependencies.key?(constraint.after.name)
        dependencies[constraint.after.name] = []
      end
      dependencies[constraint.after.name] << constraint.before.name
    end

    dependencies.tsort
  end
end
