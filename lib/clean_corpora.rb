class CleanCorpora
  def clean
    Dir["./data/raw/*.txt"].each do |file|
      lines = File.read(file).split("\n").map do |line|
        process_sentence(line)
      end.reject do |s|
        s.strip.empty?
      end

      File.write(file.gsub("raw", "clean"), lines.join("\n"))
    end
  end

  def process_sentence(sentence)
    sentence.gsub("\"", "")
            .gsub("“", "")
            .gsub("”", "")
            .gsub(" '", "")
            .gsub("' ", "")
            .gsub("(", "")
            .gsub(")", "")
            .gsub("[", "")
            .gsub("]", "")
            .gsub("_", "")
            .gsub("*", "")
            .gsub("--", "—")
            .gsub(/(\w)'(\w)/, "\\1’\\2")
  end
end
