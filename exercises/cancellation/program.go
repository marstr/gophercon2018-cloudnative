package main

import (
	"context"
	"fmt"
	"time"

	"github.com/marstr/gophercon2018-cloudnative/exercises/cancellation/sudoku"
)

func main() {
	// this is easy puzzle #5,779,165,274 from websudoku.com
	easy := sudoku.Board{
		[9]uint8{0, 0, 6, 0, 9, 7, 0, 0, 2},
		[9]uint8{5, 4, 0, 8, 0, 0, 0, 0, 1},
		[9]uint8{9, 3, 0, 0, 0, 0, 4, 0, 0},
		[9]uint8{2, 6, 0, 0, 1, 0, 0, 5, 9},
		[9]uint8{0, 7, 0, 0, 0, 0, 0, 1, 0},
		[9]uint8{4, 5, 0, 0, 6, 0, 0, 8, 7},
		[9]uint8{0, 0, 5, 0, 0, 0, 0, 4, 3},
		[9]uint8{7, 0, 0, 0, 0, 8, 0, 2, 5},
		[9]uint8{1, 0, 0, 2, 3, 0, 7, 0, 0},
	}

	// this is medium puzzle #6,575,867,821 from websudoku.com
	medium := sudoku.Board{
		[9]uint8{0, 0, 0, 0, 5, 0, 0, 6, 3},
		[9]uint8{0, 0, 0, 4, 0, 0, 9, 0, 0},
		[9]uint8{0, 1, 0, 0, 3, 0, 4, 8, 0},
		[9]uint8{7, 4, 3, 0, 0, 8, 0, 0, 0},
		[9]uint8{0, 0, 0, 3, 2, 9, 0, 0, 0},
		[9]uint8{0, 0, 0, 7, 0, 0, 3, 1, 5},
		[9]uint8{0, 5, 8, 0, 6, 0, 0, 4, 0},
		[9]uint8{0, 0, 1, 0, 0, 4, 0, 0, 0},
		[9]uint8{3, 7, 0, 0, 9, 0, 0, 0, 0},
	}

	// this is hard puzzle #7,898,333,298 from websudoku.com
	hard := sudoku.Board{
		[9]uint8{0, 0, 4, 0, 0, 3, 0, 6, 0},
		[9]uint8{0, 0, 0, 0, 6, 2, 3, 8, 0},
		[9]uint8{0, 5, 0, 1, 0, 0, 0, 0, 0},
		[9]uint8{9, 0, 1, 0, 0, 7, 0, 0, 0},
		[9]uint8{8, 0, 0, 0, 0, 0, 0, 0, 2},
		[9]uint8{0, 0, 0, 2, 0, 0, 1, 0, 4},
		[9]uint8{0, 0, 0, 0, 0, 1, 0, 5, 0},
		[9]uint8{0, 6, 9, 7, 2, 0, 0, 0, 0},
		[9]uint8{0, 1, 0, 9, 0, 0, 2, 0, 0},
	}

	// this is evil puzzle #7,463,985,158 from websudoku.com
	evil := sudoku.Board{
		[9]uint8{4, 6, 0, 9, 0, 0, 0, 0, 0},
		[9]uint8{3, 0, 0, 7, 0, 0, 9, 0, 1},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 2, 0, 5, 8, 0, 0, 7, 0},
		[9]uint8{0, 0, 1, 0, 3, 0, 8, 0, 0},
		[9]uint8{0, 3, 0, 0, 6, 7, 0, 2, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{5, 0, 7, 0, 0, 8, 0, 0, 6},
		[9]uint8{0, 0, 0, 0, 0, 2, 0, 4, 5},
	}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	go func() {
		fmt.Scanln()
		cancel()
	}()

	for i := 0; i < 100; i++ {
		select {
		case <-ctx.Done():
			break
		default:
			// Intentionally Left Blank
		}
		printAndSolve(ctx, easy)
		printAndSolve(ctx, medium)
		printAndSolve(ctx, hard)
		printAndSolve(ctx, evil)
	}
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
