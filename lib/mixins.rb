class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

def info arg
  puts ( Time.now.to_s + " INF: " + arg.to_s ).green
end

def warn arg
  puts ( Time.now.to_s + " WRN: " + arg.to_s ).yellow
end

def err arg
  puts ( Time.now.to_s + " ERR: " + arg.to_s ).red
end

def am_i_root?
  Process.uid == 0 ? true : false
end