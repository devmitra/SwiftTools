//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
func GetJumpCount(input1: Int, input2: Int, input3: [Int]) ->  Int {
    
    let lmt1: Int = 10 * 10 * 10 * 10 * 10 * 10 * 10 * 10 * 10;
    
    if input1 < 1 || input1 > lmt1 {
        return -1
    }
    
    if input2 < 1 || input2 > lmt1 / (10 * 10 * 10 * 10) {
        return -1
    }
    
    var attempts: Int = 0;
    let val = (input1 - input2);
    for height in input3 {
        var temp: Int = height;
        while temp > input1 {
            temp = temp - val;
            attempts = attempts + 1;
        }
        attempts = attempts + 1;
    }
    return attempts;
    
}

let splval: Int = Int(pow(10.0,4.0));

GetJumpCount(input1: splval, input2: 1, input3: [splval + 2])

let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 600, height: 300));
