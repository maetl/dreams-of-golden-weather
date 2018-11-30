class Entities
  @@entities = {}

  def self.date
    self.load_entities("date")
  end

  def self.event
    self.load_entities("event")
  end

  def self.fac
    self.load_entities("fac")
  end

  def self.gpe
    self.load_entities("gpe")
  end

  def self.language
    self.load_entities("language")
  end

  def self.law
    self.load_entities("law")
  end

  def self.loc
    self.load_entities("loc")
  end

  def self.money
    self.load_entities("money")
  end

  def self.norp
    self.load_entities("norp")
  end

  def self.org
    self.load_entities("org")
  end

  def self.person
    self.load_entities("person")
  end

  def self.product
    self.load_entities("product")
  end

  def self.quantity
    self.load_entities("quantity")
  end

  def self.time
    self.load_entities("time")
  end

  def self.work_of_art
    self.load_entities("work_of_art")
  end

  def self.load_entities(type)
    unless @@entities.key?(type)
      @@entities[type] = File.read("./data/entities/#{type}.txt").split("\n")
    end
    @@entities[type]
  end
end
