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
  action(:print_spool_mayhem, [:first_spooling_fault], [:first_spool_printed]),
  action(:first_incident_report, [:first_spool_printed], [:first_incident_reported]),
  action(:government_warning, [:first_incident_reported], [:first_warning_given]),
  action(:anti_authoritarian_feels, [:first_warning_given], [:goal_tick])
]

class Narrative
  def initialize
    @plan = Plan.new(InitialState, GoalState)
  end

  def plan
    @plan.generate(Actions)
  end

  def sections
    context = StoryEntities.map
    plan = @plan.generate(Actions)

    plan.map do |action|
      NarrativeActions.generate(action, context)
    end.compact
  end
end
