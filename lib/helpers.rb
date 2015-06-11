def info arg
  puts ( Time.now.to_s + "  INFO: " + arg.to_s ).green
end

def warn arg
  puts ( Time.now.to_s + "  WARN: " + arg.to_s ).yellow
end

def err arg
  puts ( Time.now.to_s + " ERROR: " + arg.to_s ).red
end

def am_i_root?
  Process.uid == 0 ? true : false
end

def is_pri?
  ( ENV['role'] == "pri" && CONFIG[:ha] ) || ! CONFIG[:ha]
end

def task_begin
  puts ( Time.now.to_s + "  INFO: " + t.name + " TASK BEGIN" ).green
end

def task_end
  puts ( Time.now.to_s + "  INFO: " + t.name + " TASK END" ).green
end