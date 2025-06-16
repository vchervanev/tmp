### How to use it

Build the image
```
docker build . -t vc-solution
```

Run with the input data mounted into the container
```
cat input.txt | docker run -i --rm vc-solution sh -c 'ruby main.rb'
```

