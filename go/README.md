```
  _____________________________________________
 /____/____/____/____/____/____/____/____/____/
/____/____/____/____/____/____/____/____/____/ 
                                  __           
   ____ _____        ____  ____  / /____  _____
  / __ `/ __ \______/ __ \/ __ \/ __/ _ \/ ___/
 / /_/ / /_/ /_____/ / / / /_/ / /_/  __(__  ) 
 \__, /\____/     /_/ /_/\____/\__/\___/____/  
/____/                                         

  _____________________________________________
 /____/____/____/____/____/____/____/____/____/
/____/____/____/____/____/____/____/____/____/ 
```

- Package name is the same as the last element of the package statement.
- Exported names must be capitalized.
- Types come after the variable name. In case of multiple parameters having same types, they can be omitted from the function signature except for the last one.
- := deduces type and assigns the values, can ONLY be used inside a function. Quote, "Outside a function, every statement begins with a keyword (var, func, and so on) and so the := construct is not available."
- Use `,` operator to easily assign multiple returned values: foo, baz := fn(1,2).
- Naked returns (use in short functions) allow return type to be defined in the function signature.
- `var` (can be functional or global level) takes in a list of variables of the same type, the type ALWAYS being the last in that line.
- Type can be omitted during declaration to allow auto-type inference.
- Multiple declarations of different types can be done in "one-go" by using parentheses the same way they are used in import statement, just use a `,`.
- Primitive types are:
  - Boolean: bool,
  - String: string,
  - Numerics:
    int{8,16,32,64},
    uint{8,16,32,64}, uintptr,
    byte (same as uint8),
    float{32,64},
    complex{64,128}
  - Character
    rune (same as int32, represents a Unicode Code Point -- "char")
- Quote, "The int, uint, and uintptr types are usually 32 bits wide on 32-bit systems and 64 bits wide on 64-bit systems. When you need an integer value you should use int unless you have a specific reason to use a sized or unsigned integer type."
- Initialized but unassigned variables are given "zero-values" based on the following rules:
  0 for numerics,
  false for booleans,
  "" for strings.
- To convert a value `v` to type T, do T(v), assuming the value is convertible to T (numerics, booleans, and strings). Quote, "Unlike in C, in Go assignment between items of different type requires an explicit conversion."
- Constants are declared using the `const` keyword, and cannot be declared using the `:=` operator.
- The basic for loop has three components separated by semicolons:
  - the init statement: executed before the first iteration
  - the condition expression: evaluated before every iteration
  - the post statement: executed at the end of every iteration
  - the init and post statements are optional -> drop ; -> while (still `for` in Go)
  - Infinite loop: for {}
- Usually, `;` and `()` are redundant, until they're absolutely needed.
- "Interim statements", or statements that occur in "intermediate" places, such as,
  ```
  // `v` will only be available inside `if`'s scope (INCLUSIVE (notice `v < lim` in the same line))
  if v := math.Pow(x, n); v < lim {
    return v
  }
  // `v` will also be available inside any chained `else` block
  if v := math.Pow(x, n); v < lim {
    return v
  } else {
    fmt.Printf("%g >= %g\n", v, lim)
  }
  // also, no implicit truthiness conversions, i.e., this throws
  // "syntax error: cannot use v := math.Pow(x, n) as value"
  if v := math.Pow(x, n) {
    return v
  }
  ```
- `switch`-`case`:
  - Go only runs the selected case (TOP DOWN ORDER), not all the cases that follow. In effect, the "break" statement that is needed at the end of each case is provided automatically in Go.
  - Go's switch cases need not be constants (can be functions as well), and the values involved need not be integers (ANY value). 
  ```
  // `os` is available for all of `switch`'s scope
  switch os := runtime.GOOS; os {
    case "darwin":
      fmt.Println("OS X.")
    case "linux":
        fmt.Println("Linux.")
    default:
          // freebsd, openbsd,
          // plan9, windows...
          fmt.Printf("%s.\n", os)
  }
  ```
  - Switch without a condition is the same as switch true. This construct can be a clean way to write long if-then-else chains. 
  ```
  switch {
    case t.Hour() < 12:
      fmt.Println("Good morning!")
    case t.Hour() < 17:
        fmt.Println("Good afternoon.")
    default:
          fmt.Println("Good evening.")
  }
  ```
- `defer` defers the execution of a function until the surrounding function is executed, stack logic is applicable.
  ```
  defer fmt.Println("world")	// waits for "hey", push "world" fn in stack
  defer fmt.Println("hey")	// waits for "hello", push "hello" fn in stack
  fmt.Println("hello")		// Stack "pop" begins from here
  // Prints "hello\nhey\nworld"
  ```
  ```
  fmt.Println("counting")
  for i := 0; i < 10; i++ {
    defer fmt.Println(i)
  }
  fmt.Println("done")
  // Prints:
  // counting
  // done
  // 9
  // 8
  // 7
  // 6
  // 5
  // 4
  // 3
  // 2
  // 1
  // 0
  ```
- A variable of type `*T` is a pointer to a `T` value. It's zero value is `nil`. The `&` operand generates the pointer address of it's associated operand. The `*` operator refers to its associated pointer operand's underlying value (dereferencing).
- A struct is a collection of fields. Use `.` operator to access a struct instances' internal field.
  ```
  type Vertex struct {
    X int
    Y int
  }
  v := Vertex{1,2}
  
  // (short-hand)
  v := struct {
      X int
      Y int
    }{1,2}
  v.X = 3 // 1 -> 3
  ```
- In case of a pointer to a struct instance, `P.f` (where `P` is the pointer and `f` is the field in the struct instance) is the same as `(*P).f` or `P->f`, however the latter operation is invalid in Go.
- Struct literals:
  ```
  type Vertex struct {
          X, Y int
  }
  var (
          v1 = Vertex{1, 2}  // has type Vertex
          v2 = Vertex{X: 1}  // Y:0 is implicit
          v3 = Vertex{}      // X:0 and Y:0
          p  = &Vertex{1, 2} // has type *Vertex
  )
  // You can list just a subset of fields by using the Name: syntax. (And the order of named fields is irrelevant.)
  ```
- `[n]T` is an array of size `n` and having type `T`.
  ```
  var arr [2]int
  arr[0] = 1
  arr[1] = 2
  // (difference b/w = and := in case of an array)
  var arr [2]int = [2]int{1,2}
  // (:= is only valid inside a function)
  arr := [2]int{1,2}
  //
  var arr [2]int
  arr = [2]int{1,2}
  //
  var arr [2]int
  arr = [2]int{1,2}
  ```
- An array has a fixed size. A slice, on the other hand, is a dynamically-sized, flexible VIEW into the elements of an array. In practice, slices are much more common than arrays. 
- The type []T is a slice with elements of type T. This selects a half-open range which includes the first element, but excludes the last one.
```
arr := [4]int{1,2,3,4}
var view []int = arr[:2] // indices supplied must me non-negative
```
- Since a slice is nothing but a "view" into an array, a slice does not store any data, it just describes a section of an underlying array. Changing the elements of a slice modifies the corresponding elements of its underlying array. Other slices that share the same underlying array will see those changes.
- Variables are also called literals.
  ```
  s := []struct {
                  i int
                  b bool
          }{
                  {2, true},
                  {3, false},
                  {5, true},
                  {7, true},
                  {11, false},
                  {13, true},
          }
  ```
- A slice always holds the initial capacity allocated to it from the array, i.e., from the first element of the slice that's in the array. The same slice can then be used multiple times to access different parts of the originally allocated section, subject to the condition that:
  - If first index is not changed, and the last index is varied.
  - If first index is changed, i.e., increased, then the new first index cannot go beyond that point (cap(S)).
- len(S) is the virtual (immediate) size, whereas cap(S) is the real (actual) size.
- The zero value of a slice is `nil`. A `nil` slice has a length and capacity of 0 and has no underlying array.
- 2D array:
  ```
  // Create a tic-tac-toe board.
  board := [][]string{
    []string{"_", "_", "_"},
      []string{"_", "_", "_"},
      []string{"_", "_", "_"},
  }
  // The players take turns.
  board[0][0] = "X"
  board[2][2] = "O"
  board[1][2] = "X"
  board[1][0] = "O"
  board[0][2] = "X"
  ```
- Use `append([]T, ...T)` to append to a slice.
- Use `range` to dynamically get indices and values in a for loop.
- Maps are of type map[K]V, where K is the key type, and V is the value type. An unassigned map has `nil` value.
  ```
    var m map[int]int
    fmt.Println(m == nil) // true

    m := map[int]int{}
    fmt.Println(m == nil) // false
  ```
- Literals require assignment at the time of declaration itself, unlike those made with `make`.
  ```
  m := map[int]int{ 1: 2 }
  m[2] = 3
  ...

  m := make(map[int]int)
  m[1] = 2
  m[2] = 3
  ...

  // If the top-level type is just a "type" name, we can omit it.
  type Vertex struct {
    X int
    Y int
  }
  s := []Vertex{
   // Instead of Vertex{1,2}, we can do,
   {1,2}
  }
  ```
- `nil` is the value of an unassigned pointer that points to nothing.
- To delete a key in map, use delete(m, k). To test for a key's presence, use `key, isPresent = m[k]`.
- Functions are values too. They can be passed around just like other values. Function values may be used as function arguments and return values. 
- Functions are declared a little differently, i.e., `func fname(a X, b Y) T {}` when not an argument, `fname func(int, int) T`, otherwise (`fname`'s datatype).
  ```
  func fn1(fn11 func(float64, float64) float64) float64 {
    return fn11(0, 0)
  }
  ```
- Go functions can be closures as well.
  ```
  package main
  import "fmt"
  func fn() func(int) int {
    product := 1
    return func(x int) int {
      product *= x
      return product
    }
  }
  func main() {
    ffn := fn()
    for i := 1; i < 10; i++ {
      fmt.Println(ffn(i))
    }
  }
  ```
- Go has methods instead of classes. A method is essentially a function that has a reciever.
```
func (rec T) fname(a X, b Y) U {} // Access by r.fname(c,d)
// Both are similar in functionality, i.e., methods are just functions.
func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
```
- (?) `type` is similar to `typedef`.
- You can define non-struct methods as well, just make sure the type of the reciever that's being used is defined in the same package (this is why primitive types (int, float64, etc.) cannot be used to form recievers).
- Use pointer recievers in methods if you want to modify the recievers' value. CAVEAT: Without a pointer (`T` instead of `*T`), a function will operate on the copy of the operand (reciever or parameters).
- Pointer-recieved-methods are more commonly used as they fit into a broader scenario. Also Go takes care of referencing (`(&s).x`) and dereferencing (`(*s).x`) so that we do not need to explicitly state those ourselves (although we can if we want). However, this is only valid when `.` operator is being used. Otherwise, we need to explicitly supply those operators.
-  There are two reasons to prefer a pointer receiver.
  - The first is so that the method can modify the value that its receiver points to.
  - The second is to avoid copying the value on each method call. This can be more efficient if the receiver is a large struct, for example. 
- In general, all methods on a given type should have either value or pointer receivers, but not a mixture of both.
- An [interface](https://en.wikipedia.org/wiki/Interface_(computing)#In_practice) is "implemented" by a type. In Go, at it's core, an interface is a tuple of a type and a value. Working on a different type requires reassigning the interface instance.
  ```
  package main
  import "fmt"
  // the type that interface implements
  type T struct {
    S string
  }
  type Float float64
  type I interface {
    // methods
    M()
  }
  func (t *T) M() {
    fmt.Println(t.S)
  }
  func (f Float) M() {
    fnt.Println(f)
  }
  func main() {
    var i I
    i = &T{"hola"}  // both "value" and "type" parts are inferred from this definition
    i.M()           
    i = 1.0         // both "value" and "type" parts are inferred from this definition
    i.M()           
  }
  // <interface definition> = <reciever definition>
  ```
- Empty interfaces can have any underlying type (initially `nil`).
- Type assertions can help to safely avoid panics. They are defined for interfaces as `value, assertion := i.(Type)`, which assigns zero value to `value` if assertion fails, [(reference)](https://tour.golang.org/methods/15).
- Type switches allow for operations based on interface's underlying "concrete type" (the assigned type).
```
switch v := i.(type) {
case T:
    // here v has type T
case S:
    // here v has type S
default:
    // no match; here v has the same type as i
}
```
- A `Stringer` `String` method looks for a `string` return type function, and looks like `func (t T) String() string {}`. This way you can automatically define print format for type `T`.
- Similarly, an `error` `Error` method looks for an `error` return type function, and looks like `func (e *E) Error() string {}`. Note that errors are checked by a `v, err := fn()` and `err != nil` way, meaning that `err`, i.e., the error-returning function should in fact return a reference to the `E` type.
- Built-in interfaces such as `Error` and `Stringer` look for `Error()` and `String()` methods internally, and these methods define what happens (AUTOMATICALLY) when an `error` or `string` is returned.
- `io.Reader` interface is implemented by many modules. One of the methods offered is the `Read` method, `func (T) Read(b []byte) (n int, err error)`, which is commonly implemented in most modules, but can be used to modify reads explicitly as well (as is the case with all interface implemented methods).
  ```
    s := strings.NewReader("Hola, amigoes!")  // stream impl using `strings.NewReader` function that returns a `*Reader` interface pointer (of `io.Reader`)
    b := make([]byte, 8)                      // stream of 8 bytes
    for {
      n, err := s.Read(b)                     // "Read" method implemented by `io.Reader` interface
      fmt.Printf("%v %v %v\n", n, err, b)
      fmt.Printf("%q\n", b[:n])
      if err == io.EOF {
        break
      }
    }

  ```
- [Goroutines](https://golangbot.com/goroutines/)
- [Channels](https://tour.golang.org/concurrency/2)
- Channels can be buffered (predefined byte stream size to satisfy before sending or recieving any data) by specifying another parameter. Sends to a buffered channel block only when the buffer is full. Receives block when the buffer is empty.
```
	ch := make(chan int, 2)
	ch <- 1
	ch <- 2
	fmt.Println(<-ch)
	ch <- 3
	fmt.Println(<-ch)
	fmt.Println(<-ch)
```
- [Range (in for loops) and Close](https://tour.golang.org/concurrency/4)
- [Select-case](https://tour.golang.org/concurrency/5) helps choose between multiple communication operations based on their status (whether they have something to offer, or if there is a reciever on the other side (?)). The `default` case does not block.
