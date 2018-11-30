class Section
  attr_reader :context, :text, :pov

  def initialize(context, text, pov)
    @context = context
    @text = text
    @pov = pov
  end
end
