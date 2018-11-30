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
  :first_fault_detected
]

GoalState = [
  :goal_tick
]

Actions = [
  action(:callout_to_centre, [:first_fault_detected], [:technician_called]),
  action(:incident_at_centre, [:technician_called], [:first_spooling_fault]),
  action(:print_spool_mayhem, [:first_spooling_fault], [:goal_tick])
]

class Narrative
  def initialize
    @plan = Plan.new(InitialState, GoalState)
  end

  def sections
    context = StoryEntities.map
    plan = @plan.generate(Actions)

    plan.compact.map do |action|
      text = NarrativeActions.generate(action, context)
      Section.new(context, text)
    end
  end
end
