NarrativeActions.new(:anti_authoritarian_feels) do |context|
  paragraphs = []
  paragraph_count = 124
  sentence_count = lambda { rand(1..7) }

  paragraph_count.times do
    paragraph = []
    sentence_count.call.times do
      case rand(1..4)
      when 1
        paragraph << Corpora.memoir_ephemera.generate
      when 2
        paragraph << Corpora.memoir.generate
      when 3
        paragraph << Corpora.computing_oeuvre.generate
      when 4
        paragraph << Corpora.memoir_oeuvre.generate
      end
    end
    paragraphs << paragraph.join("\s")
  end

  grammar = Calyx::Grammar.new do
    start paragraphs.join("\n\n")
  end

  Section.new(context, grammar.generate(context), :anarchist)
end
