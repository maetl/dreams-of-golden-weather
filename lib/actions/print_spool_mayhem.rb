NarrativeActions.new(:print_spool_mayhem) do |context|
  paragraphs = []
  paragraph_count = 22
  sentence_count = lambda { rand(1..7) }

  paragraph_count.times do
    paragraph = []
    sentence_count.call.times do
      paragraph << Corpora.computing_oeuvre.generate
    end
    paragraphs << paragraph.join("\s")
  end

  grammar = Calyx::Grammar.new do
    start paragraphs.join("\n\n")
  end

  grammar.generate(context)
end
