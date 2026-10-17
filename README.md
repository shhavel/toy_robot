# Toy Robot

A toy robot simulator on a 5 × 5 table. The robot reads commands from standard input, one command per line.

## Approach Explanation

Created a `Robot` class with a single public method, `#execute`, which accepts one of these commands: `PLACE X,Y,F`, `MOVE`, `LEFT`, `RIGHT`, `REPORT`.

`Robot` has three instance variables: `@x` and `@y`, the robot's coordinates on the 5×5 table, and `@dir` (0, 1, 2, or 3), which represents the direction the robot is facing. Multiply `@dir` by π/2 to get the angle in radians or by 90° to get the angle in degrees.

Created an executable script, `bin/robot`, that reads commands from STDIN and passes them to a `Robot` instance.

### Testing Approach

Scenario tests are implemented for the `bin/robot` script. All three scenarios described in the task are tested.

Unit tests were created for the `Robot` class. The approach is to test individual commands. After any command, the robot's state is fully described by three variables (`@x`, `@y`, and `@dir`), which are `nil` until the robot is placed.

Each command is tested when the robot is not placed. Invalid invocations are tested as well.

The scenarios were also used as the initial set of tests in `spec/lib/robot_spec.rb` and have been retained there.

## Installing dependencies

Requires Ruby 4.0.7 and Bundler. Run these commands from the project root:

```sh
gem install bundler
bundle install
```

## USAGE

Supported commands:

- `PLACE X,Y,DIRECTION` — place the robot; coordinates range from `0` to `4`, and direction must be `NORTH`, `EAST`, `SOUTH`, or `WEST`.
- `MOVE` — move the robot one cell forward.
- `LEFT` / `RIGHT` — rotate the robot 90° left or right.
- `REPORT` — print the robot's coordinates and direction.

Commands are ignored until the first valid `PLACE`. Placements outside the table and moves that would cause the robot to fall are also ignored.

### Passing commands through stdin

```sh
bin/robot <<EOF
PLACE 0,0,NORTH
MOVE
REPORT
EOF
```

Output:

```text
0,1,NORTH
```

Example with a rotation:

```sh
printf 'PLACE 0,0,NORTH\nLEFT\nREPORT\n' | bin/robot
```

Output:

```text
0,0,WEST
```

For interactive input, run `bin/robot`, enter one command per line, and press `Ctrl+D` to finish.

### Using fixtures

Sample command sequences are stored in `spec/fixtures/commands/`. Redirect a file into stdin:

```sh
bin/robot < spec/fixtures/commands/basic_movement.txt
# 0,1,NORTH

bin/robot < spec/fixtures/commands/rotation.txt
# 0,0,WEST

bin/robot < spec/fixtures/commands/complex_movement.txt
# 3,3,NORTH
```

Run your own command file in the same way:

```sh
bin/robot < commands.txt
```

## Tests

```sh
bundle exec rspec
```

## Future Improvements

- Build the direction pattern in the regular expression from `DIRECTIONS`.
- Rename `@dir` to clarify that it stores an index into `DIRECTIONS`.
- Package the solution as a gem with an executable.
- Allow extra whitespace in commands to make the format more flexible.
- Allow the robot to rotate in 45° (π/4 radians) increments and support additional directions: `NORTHEAST`, `NORTHWEST`, `SOUTHEAST`, and `SOUTHWEST`. When facing diagonally, the robot would move along both the X and Y axes in a single move.

### Tests Improvements

- Add tests in `spec/lib/robot_spec.rb` for repeated valid `PLACE` commands updating both coordinates and direction.
- Add tests confirming that invalid `PLACE` commands preserve the robot's existing position and direction, and that an invalid direction such as `UP` is rejected.
- Add a sequence test confirming that commands are ignored after an invalid initial `PLACE` and executed after a valid `PLACE`.
- Add `MOVE` tests for the north (`y = 4`) and east (`x = 4`) table boundaries.
