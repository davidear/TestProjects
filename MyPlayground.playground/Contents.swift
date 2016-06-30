//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var numbers = [20, 19, 7, 12]

let mappedNumbers = numbers.map({ number in 3 * number })

mappedNumbers


let a = {
    (number: Int) -> Int in
    let result = 3 * number
    return result
}


a(5)

let b = {
    number  in
    number * 3
}

b(8)



var name1 = 1
var name2 = 2

func nameSwap(inout name1: Int, inout name2: Int) {
    let oldName1 = name1
    name1 = name2
    name2 = oldName1
}

nameSwap(&name1, name2:  &name2)

name1
// Mr. Roboto

name2
// Mr. Potato


func componentsFromUrlString(urlString: String) -> (host: String?, path: String?) {
    let url = NSURL(string: urlString)
    return (url!.host, url!.path)
}

componentsFromUrlString("http://www.163.com/cagegory/news").host
componentsFromUrlString("http://www.163.com/cagegory/news").path



for (index, value) in "Swift".characters.enumerate() {
    print(index,value)
}







