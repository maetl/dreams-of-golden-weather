class Book
  def initialize(output_path: "output")
    @output_path = output_path
    @timestamp = Time.new.to_i
  end

  def generate
    generate_document
  end

  def generate_document
    document = Document.new(@timestamp)
    document.render_sections
    document.save_as("#{@output_path}/book-#{@timestamp}.pdf")
  end
end
