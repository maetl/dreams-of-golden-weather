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
