# Knuth Ackermann function with 3 argument: n, a, b variant
#
#  ƒ(ø,a,b) = a * b
#  ƒ(n,a,0) = 1
#  ƒ(n+1,a,b+1) = ƒ(n-1, a, ƒ(n,a,b-1) for n > 0 and b > 0
#
# RUBY_THREAD_VM_STACK_SIZE 50M
class MyBad
  def self.ack(n, a, b)
    @ack ||= {}
    @ack["#{n}:#{a}:#{b}"] = begin
      if n == 0
        a * b
      elsif b == 0
        1
      else
        ack(n-1, a, ack(n,a,b-1))
      end
    end
  end
end

def run_ack(n, a, b)
  begin
    result = nil

    begin
      result = Object.send(MyBad.ack ,n, a, b)
    rescue SystemStackError
      #yoink
      result = "undef"
    end

    puts "#{result}"
  end
end

9.times do |n|
  9.times do |a|
    9.times do |b|

      print "(#{n}:#{a}:#{b}) => "
      result = MyBad.ack(n, a, b)
      puts result

    end
  end
end
#/los
