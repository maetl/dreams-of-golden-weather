NarrativeActions.new(:anti_authoritarian_feels) do |context|
  paragraphs = []
  paragraph_count = 216
  sentence_count = lambda { rand(1..7) }

  memoir_ephemera = Corpora.memoir_ephemera
  memoir = Corpora.memoir
  computing_oeuvre = Corpora.computing_oeuvre
  memoir_oeuvre = Corpora.memoir_oeuvre

  grammar = Calyx::Grammar.new do
    start :feels
  end

  paragraph_count.times do |i|
    paragraph = []
    sentence_count.call.times do
      case rand(1..4)
      when 1
        paragraph << memoir_ephemera.generate
      when 2
        paragraph << memoir.generate
      when 3
        paragraph << computing_oeuvre.generate
      when 4
        paragraph << memoir_oeuvre.generate
      end
    end
    paragraphs << grammar.generate(context.merge(feels: paragraph.join("\s")))
  end

  Section.new(context, paragraphs.join("\n\n"), :anarchist)
end
