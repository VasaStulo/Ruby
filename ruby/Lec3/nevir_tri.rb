# count = 0
# for a in 1..85345-1
#   for b in a..85345-1
#       c = (a*a+b*b)**(0.5)
#       p [a, b, c] if a + b + c == 85345
#   end
# end

P = 0
for i in 1..85345
  for a in 1..9999999
    for b in 1..999999
      if (c = (a*a+b*b)**(0.5)) == a + b + c
    p+=a
    p+=b
    p+=c
      end
    end
  end
end

pp P