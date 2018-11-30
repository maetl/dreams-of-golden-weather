class Section
  attr_reader :context, :text

  def initialize(context, text)
    @context = context
    @text = text
  end
end
