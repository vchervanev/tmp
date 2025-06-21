docker build . -t vc-solution > /dev/null
cat input.txt | docker run -i --rm vc-solution sh -c 'ruby main.rb --echo'
