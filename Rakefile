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
  puts NarrativeActions.generate(:incident_at_centre)
end

task :dither do
  img = DitheredImage.new("./content/images/RNZAF_Strikemaster4.png")
  img.dither
  #p ChunkyPNG::Image.new(100, 100).methods
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
      sh "python bin/ner.py #{file}"
    end
  end

  task :counts do
    counter = CountEntities.new
    counter.count
  end
end
