### How to use it

Build the image
```
docker build . -t vc-solution
```

Run with the input data piped into the container
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

### Development & test

Currently, the best way to run tests or start a devcontainer is to run a regular container
```
docker run -it --rm vc-solution sh
```

and install dev tools and run tests via
```
./run-specs.rb
```
Due to the slim base image native extensions will take some time to compile.

```
/app # rspec -fd

E2E Test
  reads from stdin and outputs to stdout
  handles invalid input gracefully

Sailing
  days
    calculates the number of days between departure and arrival

Appriser
  #record
    keeps the best journey with the lowest cost
  #continue?
    returns true when no best journey
    when best journey is set
      returns false when new cost is higher
      returns true while new cost is lower
    max_legs is set
      returns false when journey size reaches it
      returns true when size < max_legs t

Cli::Formatter
  formats sailng list as JSON

CostFunction::Money
  calculates the cost

CostFunction::Time
  calculates the cost

Cost
  #accumulate
    adds up cost vectors
  comparable
    compares cost vectors

Graph
  single option A -> B -> C
    registers and visits the edges
  multiple dates for the same route
    fetches future sailings
    fetches one sailing after the middle date
    fetches no sailings after the last departure date

Json::DbLoader
  is populated with the expected data

Json::ExchangeLoader
  #parse
    parses a valid payload

Json::RateLoader
  #parse
    parses a valid payload

Json::SailingLoader
  #parse
    parses a valid payload

PathFinder
  single option A -> B -> C
    finds the path from A to C
    continue = false
      does not find the path when continue? is false

Skipper
  finds the route
  e2e routing tests
    picks the less expensive direct route
    prefers cheaper 2-leg route when allowed
    picks the shorter but more expensive direct route as fastest

28 examples, 0 failures
```