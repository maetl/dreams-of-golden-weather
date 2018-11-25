def proposition(name)
  Condition.new(subject, object)
end

def cond(subject, object)
  Condition.new(subject, object)
end

def action(label, preconditions=[], positive_effects=[], negative_effects=[])
  Action.new(label, preconditions, positive_effects, negative_effects)
end

InitialState = [
  :first_computer_fault
]

GoalState = [
  :fault_hidden_from_govt
]

Actions = [
  action(:operator_coverup, [:first_computer_fault], [:fault_hidden_from_govt])
]

class Narrative
  def initialize
    @plan = Plan.new(InitialState, GoalState)
  end

  def generate
    @plan.generate(Actions)
  end
end
