class StoryEntities
  @@memo = nil
  @@source = {}

  def self.map
    if @@memo.nil?
      @@memo = {
        technician: "Wilson",
        computer: "WEKA",
      }.merge(self.generate_story_context)
    end
    @@memo
  end

  def self.generate_story_context
    context = {}
    context[:norp] = Entities.norp
    context[:person] = Entities.person
    context[:work_of_art] = Entities.time
    context[:org] = Entities.org
    context[:gpe] = Entities.gpe
    context[:quantity] = Entities.gpe
    context[:event] = Entities.gpe
    context[:time] = Entities.time
    context[:law] = Entities.time
    context[:product] = Entities.time
    context[:percent] = Entities.time
    context[:loc] = Entities.time
    context[:fac] = Entities.time
    context[:date] = Entities.date
    context[:money] = Entities.time
    context[:language] = ["English", "Maori", "English"]

    self.max_expansions("norp").times do |i|
      context["norp#{i}".to_sym] = "{$norp}"
    end

    self.max_expansions("person").times do |i|
      context["person#{i}".to_sym] = "{$person}"
    end

    self.max_expansions("work_of_art").times do |i|
      context["work_of_art#{i}".to_sym] = "{$work_of_art}"
    end

    self.max_expansions("org").times do |i|
      context["org#{i}".to_sym] = "{$org}"
    end

    self.max_expansions("gpe").times do |i|
      context["gpe#{i}".to_sym] = "{$gpe}"
    end

    self.max_expansions("quantity").times do |i|
      context["quantity#{i}".to_sym] = "{$quantity}"
    end

    self.max_expansions("event").times do |i|
      context["event#{i}".to_sym] = "{$event}"
    end

    self.max_expansions("time").times do |i|
      context["time#{i}".to_sym] = "{$time}"
    end

    self.max_expansions("law").times do |i|
      context["law#{i}".to_sym] = "{$law}"
    end

    self.max_expansions("product").times do |i|
      context["product#{i}".to_sym] = "{$product}"
    end

    self.max_expansions("percent").times do |i|
      context["percent#{i}".to_sym] = "{$percent}"
    end

    self.max_expansions("loc").times do |i|
      context["loc#{i}".to_sym] = "{$loc}"
    end

    self.max_expansions("fac").times do |i|
      context["fac#{i}".to_sym] = "{$fac}"
    end

    self.max_expansions("date").times do |i|
      context["date#{i}".to_sym] = "{$date}"
    end

    self.max_expansions("money").times do |i|
      context["money#{i}".to_sym] = "{$money}"
    end

    self.max_expansions("language").times do |i|
      context["language#{i}".to_sym] = "{$language}"
    end

    context
  end

  def self.max_expansions(entity)
    if @@source.empty?
      File.read("./data/entities.txt").split("\n").each do |line|
        entity, count = line.split("\s")
        @@source[entity] = count.to_i
      end
    end
    @@source[entity]
  end
end
