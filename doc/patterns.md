# Code Patterns for cloud-native apps

* Best Practices in Source

- Cancellation, context.context
- http.Do() err may not be what you were expecting

* Writing a cancelable method

.code cancellation/program.go /^func longSum/,/^}/

- Use `select` to react to the first of multiple events.
- Return an `error` so that callers know you stopped because of cancellation.

* Calling a cancelable method

.code cancellation/program.go /^func main/,/^}/

- Cancellation is about culling unhelpful CPU cycles.
- Flow-control and cancellation are different.
