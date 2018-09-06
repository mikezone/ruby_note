def method
  a = 10
  while a > 5 do
    puts a
    a -= 1
    # throw :StopWhenSix if a == 6 # 相当于return 但是附带一个标签
    throw :StopWhenSix if a == 3 # 相当于return 但是附带一个标签
  end
end

catch :StopWhenSix do
  method
end