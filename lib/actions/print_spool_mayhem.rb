NarrativeActions.new(:print_spool_mayhem) do |context|
  chunks = []
  spool_chunks = 242
  sentence_count = lambda { rand(1..7) }
  one_in = lambda { |i| rand(1..i) == 1 }

  computing_oeuvre = Corpora.computing_oeuvre

  grammar = Calyx::Grammar.new(strict: false) do
    start :spool
  end

  spool_chunks.times do |i|
    chunk = []
    if one_in.call(8)
      ascii_mix = AsciiStain.sample
    else
      ascii_mix = nil
    end

    sentence_count.call.times do
      chunk << computing_oeuvre.generate
    end

    chunk_text = chunk.join("\s")

    if ascii_mix
      if one_in.call(4)
        chunk_text.split("").each_with_index do |char, i|
          if rand(1..3) == 1 && !char.match(/[A-Z\s]/).nil?
            chunk_text[i] = ascii_mix[i] || char
          end
        end
      else
        chunk_text << "\n\n" + ascii_mix
      end
    end

    chunks << grammar.generate(context.merge(spool: chunk_text))
  end

  Section.new(context, chunks.join("\n\n"), :computer)
end
