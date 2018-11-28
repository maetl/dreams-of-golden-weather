$LOAD_PATH << __dir__ + "/lib"

require "dreams_of_golden_weather"

task :generate do
  book = Book.new
  book.generate
end

task :narrative do
  narrative = Narrative.new
  p narrative.generate
end

task :narrative_actions do
  puts NarrativeActions.generate(:operator_coverup)
end

task :dither do
  img = DitheredImage.new("./content/images/templatef.png")
  img.dither
  #p ChunkyPNG::Image.new(100, 100).methods
end

task :socks do
  actions = [
    Action.new(:put_on_left_sock, [], [Condition.new(:left_sock, :wearing)], []),
    Action.new(:put_on_right_sock, [], [Condition.new(:right_sock, :wearing)], []),
    Action.new(:put_on_left_shoe, [Condition.new(:left_sock, :wearing)], [Condition.new(:left_shoe, :wearing)], []),
    Action.new(:put_on_right_shoe, [Condition.new(:right_sock, :wearing)], [Condition.new(:right_shoe, :wearing)], [])
  ]

  plan = Plan.new([], [Condition.new(:left_shoe, :wearing), Condition.new(:right_shoe, :wearing)])

  plan.generate(actions).each do |action|
    puts NarrativeActions.generate(action)
  end
end

namespace :sentences do
  task :extract do
    sentences = ExtractCorpora.new
    sentences.extract
  end
end
