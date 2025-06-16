while line = $stdin.readline do
  puts("Stdin input: #{line.chomp}")
  break if $stdin.eof?
end
