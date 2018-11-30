require "prawn"

class Document
  include Prawn::View

  def initialize(timestamp)
    @timestamp = timestamp
    @document = Prawn::Document.new(page_size: "A4")
    font_families.update(
      "Marvin Visions" => {
        bold: "fonts/MarvinVisions-Bold.ttf"
      },
      "Nouveau IBM" => {
        normal: "fonts/Nouveau-IBM.ttf"
      },
      "Noto Serif" => {
        normal: "fonts/NotoSerif-SemiCondensed.ttf",
        bold: "fonts/NotoSerif-SemiCondensedBold.ttf"
      },
      "Syne Extra" => {
        normal: "fonts/Syne-Extra.ttf"
      }
    )
    @narrative = Narrative.new
  end

  def render_appendix
    start_new_page(margin: 90)

    font("Noto Serif") do
      move_down 290
      font_size(18) { text("Appendix") }
      move_down 12
      text(File.read("./content/appendix.txt"))
    end
  end

  def render_colophon
    start_new_page(margin: 90)

    font("Noto Serif") do
      move_down 384
      font_size(18) { text("Colophon") }
      move_down 12
      text(File.read("./content/colophon.txt"))
    end
  end


  def render_preface
    start_new_page(margin: 72)

    font("Noto Serif") do
      move_down 384
      font_size(18) { text("Preface") }
      move_down 12
      text(File.read("./content/preface.txt"))
    end
  end

  def render_copyright
    start_new_page(margin: 90)

    font("Noto Serif") do
      move_down 384
      text(File.read("./content/copyright.txt"), align: :center)
    end
  end

  def render_half_title
    start_new_page(margin: 72)

    font("Noto Serif") do
      move_down 128
      font_size(18) { text("Dreams of Golden Weather", align: :center) }
    end
  end

  def render_title
    start_new_page(margin: 90)

    font("Syne Extra") do
      move_down 128
      font_size(36) { text("Dreams of Golden Weather", align: :center) }
      move_down 18
      font_size(18) { text("By Mark Rickerby", align: :center) }
    end
  end

  def render_body
    start_new_page(margin: 72)

    font("Noto Serif") do
      @narrative.sections.each do |section|
        text(section.text)
        text("\n\n§\n\n", align: :center)
      end
    end
  end

  def render_contents
    start_new_page

    font("Noto Serif") do
      move_down 128
      font_size(36) { text(@theme.title, align: :center) }
      move_down 18
      font_size(18) { text("Rule #{@rule_id}", align: :center) }
    end

    move_down 36
    image("output/rule-#{@timestamp}.png", position: :center)
  end

  def render_mashup
    canvas do
      float do
        transparent(1) do
          image("content/balloon.png", position: :center, vposition: :center, height: bounds.height)
        end
      end

      float do
        transparent(0.5) do
          image("content/card.jpg", position: :center, vposition: :center, height: bounds.height)
        end
      end

      float do
        transparent(0.3) do
          image("content/sys_block.png", position: :center, vposition: :center, height: bounds.height)
        end
      end

      font("Marvin Visions", style: :bold) do
        fill_color "FFFFFF"
        move_down 60
        font_size(90) { text("Dreams of Golden Weather", leading: -38, align: :center) }
      end
    end
  end

  def render_cover
    canvas do
      float do
        image("content/images/trouvelot_4.png", position: :center, vposition: :center, height: bounds.height)
      end

      font("Marvin Visions", style: :bold) do
        move_down 52
        font_size(90) { text("Dreams of Golden Weather", leading: -38, align: :center, color: "FFFFFF") }
      end

      move_cursor_to bounds.bottom
    end
  end

  def render_sections
    render_cover
    render_half_title
    render_title
    render_copyright
    # render_preface
    # start_new_page
    # render_contents
    render_body
    # start_new_page
    render_appendix
    # render_colophon
  end
end
