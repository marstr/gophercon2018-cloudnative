package sudoku

import "testing"

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
		t.Run("", func(t *testing.T) {
			got := validSlice(tc.vals)
			t.Log("test case: ", tc.vals)
			if got != tc.expected {
				t.Logf("got: %v want: %v", got, tc.expected)
				t.Fail()
			}
		})
	}
}
