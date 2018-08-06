package main

import (
	"context"
	"fmt"
	"os"
	"time"
)

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	a, b := 0, 1
	for i := 0; i < 10; i++ {
		fmt.Println(a)
		sum, err := longSum(ctx, a, b)
		if err != nil {
			fmt.Fprintln(os.Stderr, "Failed to sum: ", err)
			return
		}
		a, b = sum, a
	}
}

func longSum(ctx context.Context, a, b int) (int, error) {
	select {
	case <-time.After(2 * time.Second):
		return a + b, nil
	case <-ctx.Done():
		return 0, ctx.Err()
	}
}
