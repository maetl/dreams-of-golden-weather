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

task :test do
  puts NarrativeActions.generate(:callout_to_centre)
end

task :dither do
  img = DitheredImage.new("./content/images/RNZAF_Strikemaster4.png")
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

namespace :corpora do
  task :extract do
    extractor = ExtractCorpora.new
    extractor.extract
  end

  task :clean do
    cleaner = CleanCorpora.new
    cleaner.clean
  end

  task :process do
    Dir["./data/clean/*.txt"].each do |file|
      sh "python ner.py #{file}"
    end
  end
end
