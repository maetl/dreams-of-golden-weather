class DitheredImage
  def initialize(path)
    @rgb_img = ChunkyPNG::Image.from_file(path)
    @bit_img = ChunkyPNG::Image.new(@rgb_img.width, @rgb_img.height)
  end

  def resample_round_2(px)
    r = ChunkyPNG::Color.r(px)
    g = ChunkyPNG::Color.g(px)
    b = ChunkyPNG::Color.b(px)

    if ((r + g + b) / 3).round > 128
      ChunkyPNG::Color.html_color(:white)
    else
      ChunkyPNG::Color.html_color(:black)
    end
  end

  def resample_distance_2(px)
    white = ChunkyPNG::Color.html_color(:white)
    black = ChunkyPNG::Color.html_color(:black)

    to_white = ChunkyPNG::Color.euclidean_distance_rgba(px, white)
    to_black = ChunkyPNG::Color.euclidean_distance_rgba(px, black)

    if to_white < to_black
      white
    else
      black
    end
  end

  def resample_teint_2(px)
    white = ChunkyPNG::Color.html_color(:white)
    black = ChunkyPNG::Color.html_color(:black)

    teint = ChunkyPNG::Color.grayscale_teint(px)

    if teint > 128
      white
    else
      black
    end
  end

  def resample_teint_8(px)
    grey12 = ChunkyPNG::Color.from_hsv(0, 0, 0.12)
    grey24 = ChunkyPNG::Color.from_hsv(0, 0, 0.24)
    grey36 = ChunkyPNG::Color.from_hsv(0, 0, 0.36)
    grey48 = ChunkyPNG::Color.from_hsv(0, 0, 0.48)
    grey60 = ChunkyPNG::Color.from_hsv(0, 0, 0.60)
    grey72 = ChunkyPNG::Color.from_hsv(0, 0, 0.72)
    grey84 = ChunkyPNG::Color.from_hsv(0, 0, 0.84)
    grey96 = ChunkyPNG::Color.from_hsv(0, 0, 0.96)

    swatch = [
      grey12, grey24, grey36, grey48, grey60, grey72, grey84, grey96
    ]

    teint = ChunkyPNG::Color.grayscale_teint(px)

    stop = ((teint / 255.0) * 7).round

    col = swatch[stop]

    if col.nil? then raise "error: #{px}, #{stop}"; end

    col
  end

  def dither
    canvas = ChunkyPNG::Image.new(@rgb_img.width, @rgb_img.height)

    0.upto(@rgb_img.height-1) do |y|
      0.upto(@rgb_img.width-1) do |x|
        old_px = @rgb_img[x, y]
        new_px = resample_teint_8(old_px)
        canvas[x, y] = new_px
        quant_error = old_px - new_px

        if canvas.include_xy?(x + 1, y)
          canvas[x + 1, y] = canvas[x + 1, y] + quant_error * 7 / 16
        end

        if canvas.include_xy?(x - 1, y + 1)
          canvas[x - 1, y + 1] = canvas[x - 1, y + 1] + quant_error * 3 / 16
        end

        if canvas.include_xy?(x, y + 1)
          canvas[x, y + 1] = canvas[x, y + 1] + quant_error * 5 / 16
        end

        if canvas.include_xy?(x + 1, y + 1)
          canvas[x + 1, y + 1] = canvas[x + 1, y + 1] + quant_error * 1 / 16
        end
      end
    end

    canvas.save("dithered-#{Time.new.to_i}.png")
  end
end
