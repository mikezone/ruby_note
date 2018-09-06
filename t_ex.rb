def ex_in_method
  puts "a"
  raise StandardError
# rescue StandardError => ex
#   puts ex
end
#
# ex_in_method
#
# begin
#   puts "begin"
#   raise StandardError
# rescue StandardError => ex
#   puts ex
# end

require 'eventmachine'

# EM.run do
#   begin
#     address = [1, 2, 3, 4]
#     address.each do |x|
#       puts x
#       # EM.connect "baidu.com", 80
#       ex_in_method
#     end
#     rescue StandardError => e
#       puts e
#   end
# end
#
# EM.run do
#   begin
#     address = [1, 2, 3, 4]
#     address.each do |x|
#       puts x
#       begin
#         ex_in_method
#       rescue StandardError => e
#         puts e
#       end
#     end
#   end
# end

class Handler < EventMachine::Connection
  def initialize(opts = {})
    @opts = opts
  end

  def post_init
    puts "post_init"
  end

  def connection_completed
    puts "connection_completed  #{Thread.current}"
    # close_connection # 会触发unbind
    raise StandardError.new # 会触发 unbind # 在外部捕获不到异常，协程
    # throw :STOP ## 协程，使用throw 也捕获不到
  end

  def receive_data(data)
    puts "receive_data"
  end

  def unbind
    puts "unbind"
  end
end

EM.run do
  begin
    address = [1, 2, 3, 4]
    address.each do |x|
      puts x
      begin
        EM.connect "badu.com", 80, Handler
        puts "aaaa  #{Thread.current}"
      rescue StandardError => e
        puts e
      end
    end
  end
end


# EM.run do
#   begin
#     address = [1, 2, 3, 4]
#     address.each do |x|
#       puts x
#       catch :STOP do
#         EM.connect "badu.com", 80, Handler
#         puts "aaaa  #{Thread.current}"
#       end
#     end
#   end
# end