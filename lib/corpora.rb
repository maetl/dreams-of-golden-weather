module Corpora
  @@data = {}
  @@text = {}

  def self.pulp
    self.load_markov_text("pulp")
  end

  def self.computing
    self.load_markov_text("computing")
  end

  def self.memoir
    self.load_markov_text("memoir")
  end

  def self.muturangi
    self.load_markov_text("muturangi")
  end

  def self.minerals
    self.load_markov_text("minerals")
  end

  def self.ephemera
    self.load_markov_text("ephemera")
  end

  def self.computing_ephemera
    collection = self.load_sentences("computing").concat(self.load_sentences("ephemera"))
    @@data["computing_ephemera"] = collection
    self.load_markov_text("computing_ephemera")
  end

  def self.load_sentences(corpus)
    unless @@data.key?(corpus)
      @@data[corpus] = File.read("./data/nlp/#{corpus}.txt").split("\n")
    end
    @@data[corpus]
  end

  def self.load_markov_text(corpus)
    unless @@text.key?(corpus)
      @@text[corpus] = Markov::Text.new(self.load_sentences(corpus), splitter: :words)
    end
    @@text[corpus]
  end
end
