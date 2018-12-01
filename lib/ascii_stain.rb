class AsciiStain < Calyx::Grammar
  def self.sample
    if rand(0..1) == 0
      Corpora.ascii.sample
    else
      stain = AsciiStain.new
      stain.generate
    end
  end

  start :cells
  br "\n"
  cells (0..6).map { "{row}" }.join("{br}")
  row (0..70).map { "{minor}" }.join("{major}")
  minor "*", ".", ":", "+", "!", "%", "░", " "
  major "8", "0", "#", "▓"
end
