class NarrativeActions
  @@registry = {}

  def self.registry(action_name, generator)
    @@registry[action_name] = generator
  end

  def initialize(action_name, &block)
    NarrativeActions.registry(action_name, block.to_proc)
  end

  def self.generate(action_name, context)
    @@registry[action_name].call(context) unless @@registry[action_name].nil?
  end
end
