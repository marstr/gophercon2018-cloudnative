package sudoku

import (
	"fmt"
	"testing"
)

func Test_validSlice(t *testing.T) {
	testCases := []struct {
		vals     []uint8
		expected bool
	}{
		{[]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0}, true},
		{[]uint8{0, 1, 0, 0, 0, 0, 0, 0, 0}, true},
		{[]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9}, true},
		{[]uint8{1, 1, 2, 3, 4, 5, 6, 7, 8}, false},
		{[]uint8{10, 2, 3, 4, 5, 6, 7, 8, 9}, false},
	}

	for _, tc := range testCases {
		t.Run(fmt.Sprint(tc.vals), func(t *testing.T) {
			got := validSlice(tc.vals)
			if got != tc.expected {
				t.Logf("got: %v want: %v", got, tc.expected)
				t.Fail()
			}
		})
	}
}

func Test_IsSolution(t *testing.T) {
	testCases := []struct {
		original Board
		solution Board
		expected bool
	}{
		{ // A board with its valid solution
			original: Board{
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
				[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
				[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
				[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
				[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
				[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
				[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
				[9]uint8{9, 1, 2, 3, 4, 5, 6, 7, 0},
			},
			solution: Board{
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
				[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
				[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
				[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
				[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
				[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
				[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
				[9]uint8{9, 1, 2, 3, 4, 5, 6, 7, 8},
			},
			expected: true,
		},
		{ // A valid, but not quite complete board as a solution to the empty board.
			original: Board{
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
				[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
				[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
				[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
				[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
				[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
				[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
				[9]uint8{9, 1, 2, 3, 4, 5, 6, 7, 0},
			},
			expected: false,
		},
		{ // A puzzle with a legitimate solution, and a complete board that solves a different starting board.
			original: Board{
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
				[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
				[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
				[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
				[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
				[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
				[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
				[9]uint8{9, 1, 2, 3, 4, 5, 6, 0, 9},
			},
			solution: Board{
				[9]uint8{7, 8, 9, 1, 2, 3, 4, 5, 6},
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{4, 5, 6, 7, 8, 9, 1, 2, 3},
				[9]uint8{2, 3, 4, 5, 6, 7, 8, 9, 1},
				[9]uint8{5, 6, 7, 8, 9, 1, 2, 3, 4},
				[9]uint8{8, 9, 1, 2, 3, 4, 5, 6, 7},
				[9]uint8{9, 1, 2, 3, 4, 5, 6, 7, 8},
				[9]uint8{3, 4, 5, 6, 7, 8, 9, 1, 2},
				[9]uint8{6, 7, 8, 9, 1, 2, 3, 4, 5},
			},
			expected: false,
		},
	}

	for _, tc := range testCases {
		t.Run("", func(t *testing.T) {
			got := IsSolution(tc.original, tc.solution)
			if got != tc.expected {
				t.Logf("original:\n%s\n\nsolution:\n%s", tc.original, tc.solution)
				t.Fail()
			}

			if !tc.solution.Valid() {
				t.Logf("solution:\n%s", tc.solution)
				t.Error("solution is not valid")
				return
			}
		})
	}
}

func TestBoard_swapRows(t *testing.T) {
	testCases := []struct {
		a           uint8
		b           uint8
		original    Board
		transformed Board
	}{
		{
			a: 0,
			b: 1,
			original: Board{
				[9]uint8{9, 8, 7, 6, 5, 4, 3, 2, 1},
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			transformed: Board{
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{9, 8, 7, 6, 5, 4, 3, 2, 1},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
		},
		{
			a: 3,
			b: 4,
			original: Board{
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{9, 8, 7, 6, 5, 4, 3, 2, 1},
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			transformed: Board{
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{1, 2, 3, 4, 5, 6, 7, 8, 9},
				[9]uint8{9, 8, 7, 6, 5, 4, 3, 2, 1},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
		},
	}

	for _, tc := range testCases {
		t.Run("", func(t *testing.T) {
			tc.original.swapRows(tc.a, tc.b)

			if tc.original != tc.transformed {
				t.Logf("want:\n%s\ngot:\n%s", tc.transformed, tc.original)
				t.Fail()
			}
		})
	}
}

func TestBoard_swapCols(t *testing.T) {
	testCases := []struct {
		a           uint8
		b           uint8
		original    Board
		transformed Board
	}{
		{
			a: 0,
			b: 1,
			original: Board{
				[9]uint8{9, 1, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{8, 2, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{7, 3, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{6, 4, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{5, 5, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{4, 6, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{3, 7, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{2, 8, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{1, 9, 0, 0, 0, 0, 0, 0, 0},
			},
			transformed: Board{
				[9]uint8{1, 9, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{2, 8, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{3, 7, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{4, 6, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{5, 5, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{6, 4, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{7, 3, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{8, 2, 0, 0, 0, 0, 0, 0, 0},
				[9]uint8{9, 1, 0, 0, 0, 0, 0, 0, 0},
			},
		},
		{
			a: 3,
			b: 4,
			original: Board{
				[9]uint8{0, 0, 0, 1, 9, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 2, 8, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 3, 7, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 4, 6, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 5, 5, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 6, 4, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 7, 3, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 8, 2, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 9, 1, 0, 0, 0, 0},
			},
			transformed: Board{
				[9]uint8{0, 0, 0, 9, 1, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 8, 2, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 7, 3, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 6, 4, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 5, 5, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 4, 6, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 3, 7, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 2, 8, 0, 0, 0, 0},
				[9]uint8{0, 0, 0, 1, 9, 0, 0, 0, 0},
			},
		},
	}

	for _, tc := range testCases {
		t.Run("", func(t *testing.T) {
			tc.original.swapCols(tc.a, tc.b)

			if tc.original != tc.transformed {
				t.Logf("want:\n%s\ngot:\n%s", tc.transformed, tc.original)
				t.Fail()
			}
		})
	}
}
