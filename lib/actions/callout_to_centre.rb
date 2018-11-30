NarrativeActions.new(:callout_to_centre) do |context|
  grammar = Calyx::Grammar.new do
    start "{intro}\n\n{body}\n\n{outro}"
    intro "{intro1} {intro2} {intro3} {intro4} {intro5} {intro6}"
    intro1 "The {phone} is ringing and {technician} doesn’t want to {answer}."
    phone "phone", "telephone"
    answer "answer it", "pick it up"
    intro2 "He knows who {is_calling}."
    is_calling "it is", "is calling"
    intro3 Corpora.pulp.generate("He")
    intro4 Corpora.ephemera.generate
    intro5 Corpora.computing.generate
    intro6 "The {computer} computer {crashed} again."
    crashed "is offline", "has crashed", "has malfunctioned"
    body "{body1}\n\n{body2}\n\n{body3}"
    body1 (3..6).to_a.map { Corpora.muturangi.generate }.join("\s")
    body2 (4..10).to_a.map { Corpora.computing.generate }.join("\s")
    body3 (2..4).to_a.map { Corpora.muturangi.generate }.join("\s")
    outro "{outro1} "
    outro1 "What {computer} does is secret. {technician} isn’t supposed to know. He’s {seen} {code_that} {seen_list}. {lately}. {non_explanation}"
    seen "seen", "debugged", "viewed"
    code_that "code to handle", "data related to", "instructions for"
    seen_list "{$seen_problems}, {$seen_problems} and {$seen_problems}"
    seen_problems "weather prediction", "economic simulation", "military exercises", "nuclear threat analysis"
    lately "And lately {problems} that are {stranger}"
    problems "problems", "things"
    stranger "much more strange", "far stranger"
    non_explanation Corpora.computing_oeuvre.generate
  end

  Section.new(context, grammar.generate(context), :technician)
end
