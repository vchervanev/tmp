# frozen_string_literal: true

while (line = $stdin.readline)
  puts("Stdin input: #{line.chomp}")
  break if $stdin.eof?
end
