//: Playground - noun: a place where people can play

import UIKit

// Inferencia de tipo
var str = "Hello, playground"
var name: String = "Antonio"

// constantes
let pi = 3.1415

print(pi, name, 34+34, UIColor())

// Operador ternario, la condición es enviar el mismo tipo de dato
let result = 20 > 2 ? "yeah" : "false"

// Switch

let day = 3

switch day {
case 1 :
    print("lunes")
case 2,3 :
    print("Martes, Miércoles")
case 4...7:
    print("El resto de la semana")
default:
    print("Otro")
}


// Opcionales
// ? Wrapper
// ! Unwrapper

let possibleNum = Int ("24")
let result2 = possibleNum != nil ? possibleNum! : -1

// Optinal binding

if let unwrapped = possibleNum{
    print(unwrapped + 90)
} else {
    print("fail")
}


// Operador de coalescencia

let result3 = possibleNum ?? -1
print(result3)
