NarrativeActions.new(:government_warning) do |context|
  paragraphs = []
  paragraph_count = 204
  sentence_count = lambda { rand(1..7) }

  pulp_grammar = Calyx::Grammar.new(strict: false) do
    start :pulp
  end

  muturangi_pulp = Corpora.muturangi_pulp
  pulp = Corpora.pulp

  paragraph_count.times do |i|
    paragraph = []
    sentence_count.call.times do
      if rand(1..4) == 1
        paragraph << muturangi_pulp.generate
      else
        paragraph << pulp.generate
      end
    end
    paragraphs << pulp_grammar.generate(context.merge(pulp: paragraph.join("\s")))
  end

  PARG = paragraphs.join("\n\n")

  grammar = Calyx::Grammar.new do
    start "{rumours}. {last_line}."
    rumours "Rumours of the {anomaly} soon reached the highest levels of Government, though {unsure}"
    anomaly "perplexing anomaly", "{computer} fault"
    unsure "nobody really understood what it meant", "no politician was able to make sense of it"
    last_line "Call me when it can predict the economy better than I can, cackled Muldoon, and he refused to deal with it."
  end

  passages = "#{paragraphs.join("\n\n")}\n\n§\n\n#{grammar.generate(context)}"

  Section.new(context, passages, :politician)
end
