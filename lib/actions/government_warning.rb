NarrativeActions.new(:government_warning) do |context|
  paragraphs = []
  paragraph_count = 128
  sentence_count = lambda { rand(1..7) }

  paragraph_count.times do
    paragraph = []
    sentence_count.call.times do
      if rand(1..4) == 1
        paragraph << Corpora.muturangi_pulp.generate
      else
        paragraph << Corpora.pulp.generate
      end
    end
    paragraphs << paragraph.join("\s")
  end

  grammar = Calyx::Grammar.new do
    start "{pulpy}\n\n§\n\n{rumours}. {last_line}."
    rumours "Rumours of the {anomaly} soon reached the highest levels of Government, though {unsure}"
    anomaly "perplexing anomaly", "{computer} fault"
    unsure "nobody really understood what it meant", "no politician was able to make sense of it"
    last_line "Call me when it can predict the economy better than I can, cackled Muldoon, and he refused to deal with it."
    pulpy paragraphs.join("\n\n")
  end

  Section.new(context, grammar.generate(context), :politician)
end
