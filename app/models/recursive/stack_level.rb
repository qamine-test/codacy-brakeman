class Exception < Exception
end

class DescendentException < Exception
end

class ExceptionA < ExceptionB
end

class ExceptionB < ExceptionA
end
class Name
  def self.test(a)
    puts "#{a}/bla"
    eval "#{a}"
  end
end
