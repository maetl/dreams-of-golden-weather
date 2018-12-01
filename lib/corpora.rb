module Corpora
  @@data = {}
  @@text = {}
  @@ascii = []

  def self.ascii
    self.load_ascii_text
  end

  def self.pulp
    self.load_markov_text("pulp")
  end

  def self.computing
    self.load_markov_text("computing")
  end

  def self.oeuvre
    self.load_markov_text("oeuvre")
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

  def self.computing_oeuvre
    collection = self.load_sentences("computing").concat(self.load_sentences("oeuvre"))
    @@data["computing_oeuvre"] = collection
    self.load_markov_text("computing_oeuvre")
  end

  def self.memoir_ephemera
    collection = self.load_sentences("memoir").concat(self.load_sentences("ephemera"))
    @@data["memoir_ephemera"] = collection
    self.load_markov_text("memoir_ephemera")
  end

  def self.muturangi_pulp
    collection = self.load_sentences("muturangi").concat(self.load_sentences("pulp"))
    @@data["muturangi_pulp"] = collection
    self.load_markov_text("muturangi_pulp")
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

  def self.load_markov_text_depth(label, data, depth)
    unless @@text.key?(label)
      @@text[label] = Markov::Text.new(data, splitter: :words, depth: depth)
    end
    @@text[label]
  end

  def self.load_ascii_text
    if @@ascii.empty?
      Dir["./content/ascii/*.txt"].each do |file|
        @@ascii << File.read(file)
      end
    end

    @@ascii
  end
end
