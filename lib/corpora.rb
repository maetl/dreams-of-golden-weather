module Corpora
  @@data = {}

  def self.pulp
    self.load_sentences("pulp")
  end

  def self.computing
    self.load_sentences("computing")
  end

  def self.memoir
    self.load_sentences("memoir")
  end

  def self.muturangi
    self.load_sentences("muturangi")
  end

  def self.minerals
    self.load_sentences("minerals")
  end

  def self.ephemera
    self.load_sentences("ephemera")
  end

  def self.load_sentences(corpus)
    unless @@data.key?(corpus)
      @@data[corpus] = File.read("./data/#{corpus}_sentences_raw.txt").split("\n")
    end
    @@data[corpus]
  end
end
