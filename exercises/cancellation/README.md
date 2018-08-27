# Cancellation

In these exercises, you'll work to modify a Sudoku solver in order to be more responsive and use more of your CPU.

Without touching any code, you should be able to execute the command `go run program.go` and have four Sudoku puzzles solved and printed.

## Exercise 1

Modify the [`BasicManySolver`](./sudoku/basic_solver.go#BasicManySolver) so that it stops processing when `ctx.Done()` is readable.

See if you've fixed up this method by running the command below:

``` bash
go test -v -run ^TestBasicManySolver_Cancellable* ./...
```

## Exercise 2

Modify the [main method](./program.go#main) so that pressing the "Enter" key at any time terminates the program. If you need to buy time to press enter, try putting `printAndSolve` in a loop.

Hint: This will involve introducing a new Goroutine which waits for a newline to be written, then calls the "cancel" method provided by [`context.WithCancel`](https://godoc.org/context#WithCancel) or [`context.WithTimeout`](https://godoc.org/context#WithTimeout).

## Exercise 3

Update [`program.go`](./program.go) so that instead of calling `printAndSolve` it begins finding all solutions to all Sudoku puzzles by calling `BasicManySolver` with the empty Board. (This is easiest to get at by using `sudoku.Board{}`.) **It is not expected that you print out all of these solutions!** Instead print nothing until the "Enter" key has been pressed, then print the number of solutions that have been found.

## Bonus

Write your own `SolveMany`, and see if you can beat the performance of `BasicManySolver`. For instance, can you take advantage of more than 1 core without losing control of your memory consumption?