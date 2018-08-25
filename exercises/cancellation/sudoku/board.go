package sudoku

import (
	"bytes"
	"context"
	"crypto/rand"
	"errors"
	"fmt"
	"io"
	"math/big"
	"sync"
)

// ErrNoSolution is the error that will be returned when a Solver has found no solutions.
var ErrNoSolution = errors.New("no solutions")

// IsNoSolution checks to see whether or not an error is the "NoSolution" error.
func IsNoSolution(err error) bool {
	return err == ErrNoSolution
}

// Board holds 81 values, logically segragated into rows, columns, and boxes.
// The objective of Sudoku is take a board, which is partially complete, and
// decide the rest of the values. When complete, each row, column, and box has
// the digits 1-9 present exactly once.
//
// Each row is identified by a 0-based index:
//     -------------------------
//     | 0 0 0 | 0 0 0 | 0 0 0 |
//     | 1 1 1 | 1 1 1 | 1 1 1 |
//     | 2 2 2 | 2 2 2 | 2 2 2 |
//     -------------------------
//     | 3 3 3 | 3 3 3 | 3 3 3 |
//     | 4 4 4 | 4 4 4 | 4 4 4 |
//     | 5 5 5 | 5 5 5 | 5 5 5 |
//     -------------------------
//     | 6 6 6 | 6 6 6 | 6 6 6 |
//     | 7 7 7 | 7 7 7 | 7 7 7 |
//     | 8 8 8 | 8 8 8 | 8 8 8 |
//     -------------------------
//
// Each column is identified by a 0 based index:
//     -------------------------
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     -------------------------
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     -------------------------
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     | 0 1 2 | 3 4 5 | 6 7 8 |
//     -------------------------
//
// Boxes are identified in row-major fashion:
//     -------------------------
//     | 0 0 0 | 1 1 1 | 2 2 2 |
//     | 0 0 0 | 1 1 1 | 2 2 2 |
//     | 0 0 0 | 1 1 1 | 2 2 2 |
//     -------------------------
//     | 3 3 3 | 4 4 4 | 5 5 5 |
//     | 3 3 3 | 4 4 4 | 5 5 5 |
//     | 3 3 3 | 4 4 4 | 5 5 5 |
//     -------------------------
//     | 6 6 6 | 7 7 7 | 8 8 8 |
//     | 6 6 6 | 7 7 7 | 8 8 8 |
//     | 6 6 6 | 7 7 7 | 8 8 8 |
//     -------------------------
//
// Example starting board (Easy Puzzle #8,484,828,287 from websudoku.com):
//     -------------------------
//     | 6 0 0 | 3 0 7 | 8 9 0 |
//     | 0 2 0 | 0 0 1 | 0 6 0 |
//     | 7 0 0 | 0 0 0 | 0 4 0 |
//     -------------------------
//     | 0 0 0 | 2 0 0 | 0 7 3 |
//     | 3 9 0 | 7 0 6 | 0 8 5 |
//     | 2 4 0 | 0 0 5 | 0 0 0 |
//     -------------------------
//     | 0 7 0 | 0 0 0 | 0 0 6 |
//     | 0 6 0 | 1 0 0 | 0 5 0 |
//     | 0 5 3 | 9 0 4 | 0 0 8 |
//     -------------------------
type Board [9][9]uint8

// Solver takes a `Board` and finds a solution that satisfies the rules of
// Sudoku. If there are no solutions, an empty Board and an error are returned.
type Solver func(context.Context, Board) (Board, error)

// SolveMany takes a `Board` and publishes all possible solutions to the results
// channel. Regardless of whether or not there were solutions, it returns `nil`.
// It may return an error in the case that the context forced an early exit, or
// if the implementation relies on a method that returns an uncaught error.
type SolveMany func(ctx context.Context, puzzle Board, results chan<- Board) error

// ManyToOneConverter wraps a SolveMany to allow
type ManyToOneConverter SolveMany

// Solve finds the first solution (even if there are many) then
func (converter ManyToOneConverter) Solve(ctx context.Context, puzzle Board) (Board, error) {
	var err error
	results := make(chan Board, 1)

	wrappedCtx, cancel := context.WithCancel(ctx)
	defer cancel() // This informs the instance of SolveMany that we're not listening any more.

	go func() {
		err = converter(wrappedCtx, puzzle, results)
		close(results)
	}()

	select {
	case <-ctx.Done():
		// Solver was unable to finish executing before our context was cancelled.
		err = ctx.Err()
		return Board{}, err
	case result, ok := <-results:
		if ok {
			return result, nil
		}
		if err != nil {
			return Board{}, err
		}
		return Board{}, ErrNoSolution
	}
}

// Row fetches the value from each column in a particular row.
func (b Board) Row(r uint8) []uint8 {
	return b[r][:]
}

// Col fetches the value from each row in a particular column.
func (b Board) Col(c uint8) []uint8 {
	results := make([]uint8, len(b[0]))
	for i := 0; i < len(b[0]); i++ {
		results[i] = b[i][c]
	}
	return results
}

// Box returns each of the values in a particular box.
func (b Board) Box(r uint8) []uint8 {
	const boxWidth = 3
	const boxHeight = boxWidth

	rowOffset, colOffset := r/boxWidth*boxHeight, r%boxWidth*boxWidth

	results := make([]uint8, len(b[0]))
	for i := uint8(0); i < boxHeight; i++ {
		for j := uint8(0); j < boxWidth; j++ {
			results[i*boxWidth+j] = b[i+rowOffset][j+colOffset]
		}
	}
	return results
}

// validSlice examines a slice for duplicate values or values that are larger than
// permitted in a Sudoku puzzle.
func validSlice(vals []uint8) bool {
	const boardWidth = 9
	seen := make(map[uint8]struct{}, boardWidth)

	for i := range vals {
		_, ok := seen[vals[i]]
		if (vals[i] != 0 && ok) || vals[i] > boardWidth {
			return false
		}
		seen[vals[i]] = struct{}{}
	}
	return true
}

// completeSlice determines whether or not a slice is both a `validSlice` and contains
// no blank spaces.
func completeSlice(vals []uint8) bool {
	for i := 0; i < len(vals); i++ {
		if vals[i] == 0 {
			return false
		}
	}
	return validSlice(vals)
}

// applySlicePredicate runs a test on each row, column, and box on a Board to ensure
// each conforms.
func (b Board) applySlicePredicate(predicate func([]uint8) bool) bool {
	const boardWidth = 9
	for i := uint8(0); i < boardWidth; i++ {
		if !(predicate(b.Row(i)) && predicate(b.Col(i)) && predicate(b.Box(i))) {
			return false
		}
	}
	return true
}

// Solved determines whether or not this Board is both `Valid` and has no further values
// to be filled in.
func (b Board) Solved() bool {
	return b.applySlicePredicate(completeSlice)
}

// Valid determines whether or not this Board has any duplicate or out-of-bounds values.
// When no duplicates or out-of-bounds values are found, true is returned, otherwise false.
func (b Board) Valid() bool {
	return b.applySlicePredicate(validSlice)
}

var builderPool = sync.Pool{
	New: func() interface{} {
		return new(bytes.Buffer)
	},
}

// String creates a textual representation of a Sudoku puzzle.
func (b Board) String() string {
	const boardWidth = 9
	const boxWidth = 3
	const boxHeight = boxWidth

	const horizontalSeparator = "-------------------------"

	builder := builderPool.Get().(*bytes.Buffer)
	defer builderPool.Put(builder)
	builder.Reset()

	for i := uint8(0); i < boardWidth; i++ {
		if i%boxHeight == 0 {
			fmt.Fprintln(builder, horizontalSeparator)
		}

		for j := uint8(0); j < boardWidth; j++ {
			if j%boxWidth == 0 {
				builder.WriteString("| ")
			}
			fmt.Fprintf(builder, "%d ", b[i][j])
		}
		fmt.Fprintln(builder, "|")
	}
	fmt.Fprint(builder, horizontalSeparator)
	return builder.String()
}

func IsSolution(original, solution Board) bool {
	if !solution.Solved() {
		return false
	}

	for i := range original {
		for j := range original[i] {
			if val := original[i][j]; val != 0 && val != solution[i][j] {
				return false
			}
		}
	}

	return true
}

// GenerateBoard creates a
func GenerateBoard(missing uint8) (Board, error) {
	return GenerateBoardFrom(rand.Reader, missing)
}

func GenerateBoardFrom(reader io.Reader, missing uint8) (Board, error) {
	retval := &Board{
		[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
		[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
		[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
		[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
		[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
		[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
		[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
		[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
		[9]uint8{9, 1, 2, 3, 4, 5, 6, 7, 8},
	}

	err := retval.scramble(reader)
	if err != nil {
		return Board{}, err
	}

	boardWidth := big.NewInt(9)

	removed := uint8(0)
	for removed < missing {
		rawRow, err := rand.Int(reader, boardWidth)
		if err != nil {
			return Board{}, err
		}
		row := rawRow.Uint64()

		rawCol, err := rand.Int(reader, boardWidth)
		if err != nil {
			return Board{}, err
		}
		col := rawCol.Uint64()

		if retval[row][col] != 0 {
			retval[row][col] = 0
			removed++
		}
	}

	return *retval, nil
}

// Scramble swaps random columns and rows within box boundaries, so that the board stays
// valid, but is in a new configuration.
func (b *Board) scramble(reader io.Reader) error {
	const boxWidth = 3
	bigBoxWidth := big.NewInt(boxWidth)
	lessBigBox := big.NewInt(boxWidth - 1)

	// Given a function that knows how to swap a row or column, generate two random slices that should be swapped.
	// However, only rows/columns inside the same box may be swapped, or an invalid board state may be derived.
	swapper := func(swap func(uint8, uint8)) error {
		var x, y, offset uint8

		rows := []uint8{0, 1, 2}

		rawX, err := rand.Int(reader, bigBoxWidth)
		if err != nil {
			return err
		}
		x = rows[rawX.Int64()]
		rows = append(rows[:rawX.Int64()], rows[rawX.Int64()+1:]...)

		rawY, err := rand.Int(reader, lessBigBox)
		if err != nil {
			return err
		}
		y = rows[rawY.Int64()]

		rawOffset, err := rand.Int(reader, bigBoxWidth)
		if err != nil {
			return err
		}
		offset = boxWidth * uint8(rawOffset.Uint64())

		swap(offset+x, offset+y)
		return nil
	}

	for i := 0; i < 400; i++ {
		swapper(b.swapRows)
		swapper(b.swapCols)
	}
	return nil
}

func (b *Board) swapRows(x, y uint8) {
	for i := range b[x] {
		temp := b[x][i]
		b[x][i] = b[y][i]
		b[y][i] = temp
	}
}

func (b *Board) swapCols(x, y uint8) {
	for i := range b {
		temp := b[i][x]
		b[i][x] = b[i][y]
		b[i][y] = temp
	}
}
