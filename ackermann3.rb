##
# https://www.saylor.org/site/wp-content/uploads/2013/04/Ackermann-Function.pdf
#
# Ackermann's original three-argument function: ƒ(m,n,p) is
# defined recursively as follows for nonnegative integers m, n, and p:
#
#  ƒ(m,n,0) = m + n
#  ƒ(m,0,1) = 0
#  ƒ(m,0,2) = 1
#  ƒ(m,0,p) = m for p > 2
#  ƒ(m,n,p) = ƒ(m, ƒ(m,n - 1,p), p - 1) for n > 0 and p > 0
#
#  Usage: ruby ./ackerman3.rb raw | ack
#
# RUBY_THREAD_VM_STACK_SIZE 1G
##

fun = ARGV[0]

def ack(m, n, p)
  @ack ||= {}
  @ack["#{m}:#{n}:#{p}"] = begin
    if p == 0
      m + n
    elsif n == 0 && p > 2
      m
    elsif n == 0 && p > 0
      p - 1
    else
      ack(m, ack(m,n - 1,p), p - 1)
    end
  end
end

def raw(m, n, p)
  if p == 0
    m + n
  elsif n == 0 && p > 2
    m
  elsif n == 0 && p > 0
    p - 1
  else
    raw(m, raw(m,n - 1,p), p - 1)
  end
end

def do_ack(func, m, n, p)
  begin
    print "#{func} (#{m}, #{n}, #{p}) => "
    result = nil

    begin
      result = Object.send(func, m, n, p)
    rescue SystemStackError
      #yoink
      result = "undef"
    end

    puts "#{result}"
  end
end

9.times do |m|
  9.times do |n|
    9.times do |p|

      if (m+n+p) < 9
        do_ack(fun, m, n, p)
      end

    end
  end
end

#/los
