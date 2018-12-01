NarrativeActions.new(:print_spool_mayhem) do |context|
  paragraphs = []
  paragraph_count = 136
  sentence_count = lambda { rand(1..7) }
  one_in = lambda { |i| rand(1..i) == 1 }

  paragraph_count.times do
    paragraph = []
    if one_in.call(3)
      ascii_mix = AsciiStain.sample
    else
      ascii_mix = nil
    end
    sentence_count.call.times do
      paragraph << Corpora.computing_oeuvre.generate
    end

    paragraph_text = paragraph.join("\s")

    if ascii_mix
      if one_in.call(4)
        paragraph_text.split("").each_with_index do |char, i|
          if rand(1..3) == 1 && !char.match(/[A-Z\s]/).nil?
            paragraph_text[i] = ascii_mix[i] || char
          end
        end
      else
        paragraph_text << "\n\n" + ascii_mix
      end
    end

    paragraphs << paragraph_text
  end

  grammar = Calyx::Grammar.new do
    start paragraphs.join("\n\n")
  end

  Section.new(context, grammar.generate(context), :computer)
end
