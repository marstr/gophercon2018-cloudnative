package presentation_test

import (
	"context"
	"fmt"
	"time"
)

func ExampleReadWriteBufferedChannel() {
	nums := make(chan int, 3)
	nums <- 1
	nums <- 2
	nums <- 3
	fmt.Println(<-nums)
	fmt.Println(<-nums)
	fmt.Println(<-nums)

	// Output:
	// 1
	// 2
	// 3
}

func ExampleSelectBlock() {
	evens, odds := make(chan int), make(chan int)

	produce := func(start int, output chan<- int) {
		for {
			output <- start
			start += 2
		}
	}

	go produce(0, evens)
	go produce(1, odds)

	for i := 0; i < 4; i++ {
		select {
		case n := <-evens:
			fmt.Println(n)
		case n := <-odds:
			fmt.Println(n)
		}
	}
}

func ExampleBasicFibonacci() {
	fibonacci := make(chan int)

	producer := func(output chan<- int) {
		a, b := 0, 1
		for {
			output <- a
			a, b = b, a+b
		}
	}

	go producer(fibonacci)

	for i := 0; i < 10; i++ {
		fmt.Print(<-fibonacci, " ")
	}

	// Output:
	// 0 1 1 2 3 5 8 13 21 34
}

func ExampleCancellableFibonacci() {
	fibonacci, cancel := make(chan int), make(chan struct{})
	defer close(cancel)

	go func(output chan<- int, done <-chan struct{}) {
		a, b := 0, 1
		for {
			select {
			case <-done:
				return
			case output <- a:
				a, b = b, a+b
			}
		}
	}(fibonacci, cancel)

	for i := 0; i < 10; i++ {
		fmt.Print(<-fibonacci, " ")
	}

	// Output:
	// 0 1 1 2 3 5 8 13 21 34
}

func ExampleContextFibonacci() {
	fibonacci := make(chan int)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	go func(ctx context.Context, output chan<- int) error {
		a, b := 0, 1
		for {
			select {
			case <-ctx.Done():
				return ctx.Err()
			case output <- a:
				a, b = b, a+b
			}
		}
	}(ctx, fibonacci)

	for i := 0; i < 10; i++ {
		fmt.Print(<-fibonacci, " ")
	}

	// Output:
	// 0 1 1 2 3 5 8 13 21 34
}

func ExampleDefaultClause() {
	cancel := make(chan struct{})

	sumFinder := func(done <-chan struct{}, nums ...int) (sum int) {
		for i := range nums {
			select {
			case <-done:
				return
			default:
				// Intentionally Left Blank
			}
			sum += nums[i]
			time.Sleep(1 * time.Second)
		}
		return
	}

	fmt.Print(sumFinder(cancel, 1, 2, 3, 4), " ")
	close(cancel)
	fmt.Print(sumFinder(cancel, 10, 20, 30, 40))

	// Output:
	// 10 0
}

// START CONTEXT DEF
type Context interface {
	Deadline() (time.Time, bool)
	Done() <-chan struct{}
	Err() error
	Value(key interface{}) interface{}
}

// END CONTEXT DEF

type CancelFunc func()

func WithCancel(parent Context) (ctx Context, cancel CancelFunc) {
	panic("you meant to call `context.WithCancel`")
}

func WithDeadline(parent Context, d time.Time) (Context, CancelFunc) {
	panic("you meant to call `context.WithDeadline`")
}

func WithTimeout(parent Context, t time.Duration) (Context, CancelFunc) {
	panic("you meant to call `context.WithTimeout`")
}

func WithValue(parent Context, key, val interface{}) Context {
	panic("you meant to call `context.WithValue`")
}
