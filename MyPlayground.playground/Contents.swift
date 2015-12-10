//: Playground - noun: a place where people can play

import UIKit


let NUMBER: Int = 10;

var str = "Hello world";
var number = 20;


var x = 20
x = 30

//constants
let tup: (day: Int, month: Int, year: Int) = (10, 10, 10)
let day = tup.day

let tuple = (100, 1.5, 10)
let value = tuple.1

func multiply(x: Int, y: Int) -> Int {
    return x * y
}
multiply(5, y: 6)

//pointers
func pointer(inout x: Int) {
    x++
    print(x)
}
var test = 6
pointer(&test)
print(test)

//recursion
func fibonacci(x: Int) -> Int {
    if(x <= 2) {
        return 1;
    }
    return fibonacci(x - 1) + fibonacci(x - 2)
}

fibonacci(1)  // = 1
fibonacci(2)  // = 1
fibonacci(3)  // = 2
fibonacci(4)  // = 3
fibonacci(5)  // = 5
fibonacci(10) // = 55

