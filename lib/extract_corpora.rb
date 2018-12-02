class ExtractCorpora
  def extract
    corpora = {}

    Dir["./content/sources/**/*.txt"].each do |source|
      corpus = File.basename(File.dirname(source))
      corpora[corpus] = [] unless corpora.key?(corpus)

      text = File.read(source, :encoding => 'utf-8')
      tokenizer = Punkt::SentenceTokenizer.new(text)
      result = tokenizer.sentences_from_text(text, :output => :sentences_text, :realign_boundaries => true)

      corpora[corpus].concat(result)
    end

    corpora.keys.each do |key|
      sentences = clean_sentences(corpora[key])
      File.write("./data/raw/#{key}.txt", sentences.join("\n"))
    end
  end

  def clean_sentences(sentences)
    sentences.map do |line|
      line.gsub(/(\w|,)\n/, "\\1\s")
          .gsub("\"", "")
          .gsub("{", "[")
          .gsub("}", "]")
          .strip
    end.reject do |line|
      /^[A-Z0-9\s\.]+$/.match(line)
    end.reject do |line|
      /[\s*]+$/.match(line)
    end
  end
end
