package sudoku

import (
	"context"
	"testing"
	"time"
)

func TestBasicManySolver_CancellableWhileReading(t *testing.T) {
	const timeout = 3 * time.Second
	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()

	medium := Board{}

	solutions := make(chan Board)
	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case <-solutions:
				// Intentionally Left Blank
			}
		}
	}()

	done := make(chan struct{})
	go func() {
		defer close(done)

		failFast, quickCancel := context.WithTimeout(ctx, 1*time.Second)
		defer quickCancel()

		err := BasicManySolver(failFast, medium, solutions)
		if err != context.DeadlineExceeded {
			t.Logf("got: %v want: %v", err, context.DeadlineExceeded)
			t.Fail()
		}
	}()

	select {
	case <-done:
		// Intentionally Left Blank
	case <-ctx.Done():
		t.Logf("Timed out! Cancellation not respected within %v.", timeout)
		t.Fail()
	}
}
func TestBasicManySolver_CancellableWhileNotReading(t *testing.T) {
	const timeout = 3 * time.Second
	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()

	done := make(chan struct{})

	go func() {
		defer close(done)

		solutions := make(chan<- Board)
		failFast, quickCancel := context.WithTimeout(ctx, 1*time.Second)
		defer quickCancel()

		err := BasicManySolver(failFast, Board{}, solutions)
		if err != context.DeadlineExceeded {
			t.Logf("got: %v want: %v", err, context.DeadlineExceeded)
			t.Fail()
		}
	}()

	select {
	case <-done:
		// Intentionally Left Blank
	case <-ctx.Done():
		t.Logf("Timed out! Cancellation not respected within %v.", timeout)
		t.Fail()
	}
}

func BenchmarkBasicManySolver(b *testing.B) {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// this is medium puzzle #6,575,867,821 from websudoku.com
	medium := Board{
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

	results := make(chan Board, 10)

	go func() {
		for {
			select {
			case <-ctx.Done():
				return
			case <-results:
			}
		}
	}()

	b.ReportAllocs()
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		if err := BasicManySolver(ctx, medium, results); err != nil {
			b.Error(err)
			return
		}
	}
}
