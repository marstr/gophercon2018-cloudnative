package main

import (
	"context"
	"fmt"
	"time"

	"github.com/marstr/gophercon2018-cloudnative/exercises/cancellation/sudoku"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	solutions := make(chan sudoku.Board)

	go func() {
		fmt.Scanln()
		cancel()
		close(solutions)
	}()

	go sudoku.BasicManySolver(ctx, sudoku.Board{}, solutions)

	i := 0
	for range solutions {
		i++
	}

	fmt.Println(i)
}

func printAndSolve(ctx context.Context, subject sudoku.Board) {

	start := time.Now()
	sln, err := sudoku.ManyToOneConverter(sudoku.BasicManySolver).Solve(ctx, subject)
	elapsed := time.Since(start)

	if err == nil {
		fmt.Printf("Original:\n\n%s\n", subject)
		fmt.Printf("Solution (found after %v):\n\n%s\n", elapsed, sln)
	}
}
