NarrativeActions.new(:callout_to_centre) do |context|
  grammar = Calyx::Grammar.new do
    start "{intro}\n\n{dialogue}"
    intro "{m_sentence} {m_sentence} {m_sentence}", "{m_sentence} {m_sentence}"
    dialogue "{talks1}\n\n{talks2}\n\n{talks3}\n\n{talks4}\n\n{talks5}\n\n{talks6}\n\n{talks7}\n\n{talks8}"
    talks1 "That can’t be right."
    talks2 "Who’s to say? {m_sentence}"
    talks3 "What do we do now?"
    talks4 "{keep_quiet}. Don’t say anything to anyone."
    keep_quiet "Keep it quiet", "We keep this to ourselves"
    talks5 "It might be too late.", "What if it’s too late?"
    talks6 "Those {fools} {rigged_it} with economic surveys from Russia and Red China and now it’s gone {haywire}."
    fools "idiots", "fools"
    rigged_it "rigged it", "loaded it up", "kicked it off"
    haywire "off the rails", "haywire", "wild"
    talks7 "{theyll} think we’re {communists}."
    communists "communists", "subversives"
    theyll "Shit, they’ll", "They’ll", "They’re gonna"
    talks8 "They already do."
    m_sentence Corpora.muturangi.generate
  end

  Section.new(context, grammar.generate(context), :technician)
end
