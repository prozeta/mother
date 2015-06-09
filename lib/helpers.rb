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