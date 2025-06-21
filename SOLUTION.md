### How to use it

Build the image
```
docker build . -t vc-solution
```

Run with the input data mounted into the container
```
cat input.txt | docker run -i --rm vc-solution sh -c 'ruby main.rb'
```

to combine input parameters and results use `--echo`:
```
cat input.txt | docker run -i --rm vc-solution sh -c 'ruby main.rb --echo'
```

for interactive test just use the following command and CTRL+D to finish testing.
```
docker run -it --rm vc-solution sh -c 'ruby main.rb'
```
