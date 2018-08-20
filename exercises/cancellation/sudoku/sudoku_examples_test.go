package sudoku_test

import (
	"context"
	"fmt"
	"time"

	"github.com/marstr/gophercon2018-cloudnative/exercises/cancellation/sudoku"
)

func ExampleBasicManySolver() {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

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

	solutions := make(chan sudoku.Board)

	// Read all solutions until no more are found
	go func() {
		for {
			select {
			case <-ctx.Done(): // Out of time!
				return
			case sln, ok := <-solutions: // Solution found, or channel closed
				if ok {
					fmt.Println(sln)
				} else {
					return
				}
			}
		}
	}()

	err := sudoku.BasicManySolver(ctx, easy, solutions)
	close(solutions)
	if err != nil {
		fmt.Println(err)
	}

	// Output:
	// -------------------------
	// | 8 1 6 | 4 9 7 | 5 3 2 |
	// | 5 4 7 | 8 2 3 | 9 6 1 |
	// | 9 3 2 | 1 5 6 | 4 7 8 |
	// -------------------------
	// | 2 6 8 | 7 1 4 | 3 5 9 |
	// | 3 7 9 | 5 8 2 | 6 1 4 |
	// | 4 5 1 | 3 6 9 | 2 8 7 |
	// -------------------------
	// | 6 2 5 | 9 7 1 | 8 4 3 |
	// | 7 9 3 | 6 4 8 | 1 2 5 |
	// | 1 8 4 | 2 3 5 | 7 9 6 |
	// -------------------------
}

func ExampleBoard_Row() {
	subject := sudoku.Board{
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
	}

	fmt.Println(subject.Row(2))

	// Output:
	// [1 2 3 4 5 6 7 8 9]
}

func ExampleBoard_Col() {
	subject := sudoku.Board{
		[9]uint8{0, 0, 0, 0, 1, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 2, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 3, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 4, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 5, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 6, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 7, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 8, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 9, 0, 0, 0, 0},
	}

	fmt.Println(subject.Col(4))

	// Output:
	// [1 2 3 4 5 6 7 8 9]
}

func ExampleBoard_Box() {
	subject := sudoku.Board{
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 1, 0, 0, 2, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 3, 0, 0, 4, 0, 0, 5, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
		[9]uint8{0, 0, 0, 0, 0, 0, 1, 2, 3},
		[9]uint8{0, 6, 0, 0, 7, 0, 4, 5, 6},
		[9]uint8{0, 0, 0, 0, 0, 0, 7, 8, 9},
	}

	fmt.Println(subject.Box(8))

	// Output:
	// [1 2 3 4 5 6 7 8 9]
}

func ExampleBoard_String() {
	subject := sudoku.Board{
		[9]uint8{0, 0, 0, 1, 1, 1, 2, 2, 2},
		[9]uint8{0, 0, 0, 1, 1, 1, 2, 2, 2},
		[9]uint8{0, 0, 0, 1, 1, 1, 2, 2, 2},
		[9]uint8{3, 3, 3, 4, 4, 4, 5, 5, 5},
		[9]uint8{3, 3, 3, 4, 4, 4, 5, 5, 5},
		[9]uint8{3, 3, 3, 4, 4, 4, 5, 5, 5},
		[9]uint8{6, 6, 6, 7, 7, 7, 8, 8, 8},
		[9]uint8{6, 6, 6, 7, 7, 7, 8, 8, 8},
		[9]uint8{6, 6, 6, 7, 7, 7, 8, 8, 8},
	}

	fmt.Println(subject)

	// Output:
	// -------------------------
	// | 0 0 0 | 1 1 1 | 2 2 2 |
	// | 0 0 0 | 1 1 1 | 2 2 2 |
	// | 0 0 0 | 1 1 1 | 2 2 2 |
	// -------------------------
	// | 3 3 3 | 4 4 4 | 5 5 5 |
	// | 3 3 3 | 4 4 4 | 5 5 5 |
	// | 3 3 3 | 4 4 4 | 5 5 5 |
	// -------------------------
	// | 6 6 6 | 7 7 7 | 8 8 8 |
	// | 6 6 6 | 7 7 7 | 8 8 8 |
	// | 6 6 6 | 7 7 7 | 8 8 8 |
	// -------------------------
	//
}

func ExampleBoard_Solved() {
	empty := sudoku.Board{}
	fmt.Println(empty.Solved())

	// Sample puzzle #3398 from sudoku-solutions.com
	complete := sudoku.Board{
		[9]uint8{1, 3, 9, 6, 7, 2, 4, 5, 8},
		[9]uint8{6, 2, 8, 1, 5, 4, 9, 3, 7},
		[9]uint8{4, 5, 7, 3, 9, 8, 1, 2, 6},
		[9]uint8{3, 1, 4, 7, 8, 5, 2, 6, 9},
		[9]uint8{8, 6, 5, 2, 3, 9, 7, 4, 1},
		[9]uint8{7, 9, 2, 4, 6, 1, 5, 8, 3},
		[9]uint8{5, 8, 6, 9, 2, 7, 3, 1, 4},
		[9]uint8{2, 7, 1, 8, 4, 3, 6, 9, 5},
		[9]uint8{9, 4, 3, 5, 1, 6, 8, 7, 2},
	}
	fmt.Println(complete.Solved())

	// Output:
	// false
	// true
}

func ExampleBoard_Valid() {
	empty := sudoku.Board{}
	fmt.Println(empty.Valid())

	// Sample puzzle #3398 from sudoku-solutions.com
	complete := sudoku.Board{
		[9]uint8{1, 3, 9, 6, 7, 2, 4, 5, 8},
		[9]uint8{6, 2, 8, 1, 5, 4, 9, 3, 7},
		[9]uint8{4, 5, 7, 3, 9, 8, 1, 2, 6},
		[9]uint8{3, 1, 4, 7, 8, 5, 2, 6, 9},
		[9]uint8{8, 6, 5, 2, 3, 9, 7, 4, 1},
		[9]uint8{7, 9, 2, 4, 6, 1, 5, 8, 3},
		[9]uint8{5, 8, 6, 9, 2, 7, 3, 1, 4},
		[9]uint8{2, 7, 1, 8, 4, 3, 6, 9, 5},
		[9]uint8{9, 4, 3, 5, 1, 6, 8, 7, 2},
	}
	fmt.Println(complete.Valid())

	// Output:
	// true
	// true
}

func ExampleManyToOneConverter() {
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Minute)
	defer cancel()

	var mySolver sudoku.Solver = sudoku.ManyToOneConverter(sudoku.BasicManySolver).Solve

	sln, err := mySolver(ctx, sudoku.Board{})
	if err != nil {
		fmt.Println("err:", err)
		return
	}

	fmt.Println(sln)
	// Output:
	// -------------------------
	// | 1 2 3 | 4 5 6 | 7 8 9 |
	// | 4 5 6 | 7 8 9 | 1 2 3 |
	// | 7 8 9 | 1 2 3 | 4 5 6 |
	// -------------------------
	// | 2 1 4 | 3 6 5 | 8 9 7 |
	// | 3 6 5 | 8 9 7 | 2 1 4 |
	// | 8 9 7 | 2 1 4 | 3 6 5 |
	// -------------------------
	// | 5 3 1 | 6 4 2 | 9 7 8 |
	// | 6 4 2 | 9 7 8 | 5 3 1 |
	// | 9 7 8 | 5 3 1 | 6 4 2 |
	// -------------------------
}
