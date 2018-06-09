module API

  def insecure_command_execution
    Open3.capture2 "ls #{params[:dir]}"
  end
end
class Name
  def self.test(a)
    puts "#{a}/bla"
    eval "#{a}"
  end
end
