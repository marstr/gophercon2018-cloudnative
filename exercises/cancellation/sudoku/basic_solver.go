package sudoku

import (
	"context"
)

// BasicManySolver recurses over all `Valid` boards beyond the one that was given to it.
// Whenever it finds  a solution, in publishes it.
func BasicManySolver(ctx context.Context, puzzle Board, solutions chan<- Board) (err error) {
	select {
	case <-ctx.Done():
		return ctx.Err()
	default:
		// Intentionally Left Blank
	}

	// If the puzzle isn't valid, there are no solutions.
	if !puzzle.Valid() {
		return
	}

	// If the puzzle is solved, there's no work to do. Publish and return.
	if puzzle.Solved() {
		select {
			case solutions <- puzzle:
				return nil
			case <-ctx.Done():
				return ctx.Err()
		}
	}

	// Find the first blank spot on the board to begin traversal. We know there's at least
	// one open spot, or the `Solved` clause would have tripped.
	var firstOpenRow, firstOpenCol int
outer:
	for i := 0; i < len(puzzle); i++ {
		for j := 0; j < len(puzzle[i]); j++ {
			if puzzle[i][j] == 0 {
				firstOpenRow, firstOpenCol = i, j
				break outer
			}
		}
	}

	for i := uint8(1); i <= uint8(len(puzzle)); i++ {
		puzzle[firstOpenRow][firstOpenCol] = i
		err = BasicManySolver(ctx, puzzle, solutions)
		if err != nil {
			return
		}
	}

	return
}
