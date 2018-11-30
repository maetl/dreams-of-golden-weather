class CountEntities
  def count
    entities = Dir["./data/entities/*.txt"].entries.map do |file|
      File.basename(file, ".txt")
    end

    counts = []
    entities.each do |entity|
      counts << "#{entity} #{max_expansions(entity)}"
    end

    File.write("./data/entities.txt", counts.join("\n"))
  end

  def max_expansions(entity)
    raw = read_all_source_files
    matches = raw.scan(/({#{entity}([0-9]+)})/)
    matches.map { |m| m.last.to_i }.max
  end

  def read_all_source_files
    if @source.nil?
      source = ""
      Dir["./data/nlp/*.txt"].each do |file|
        source << File.read(file)
      end
      @source = source
    end
    @source
  end
end
