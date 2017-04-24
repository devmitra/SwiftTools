//: Playground - noun: a place where people can play

import UIKit
import SwiftTools

var str = "Hello, playground"

let dat: Data = try! Data(contentsOf: Bundle.main.url(forResource: "Sample", withExtension: "xml")! )
let map: XMLMap = XMLMap();
map.parse(xmlData: dat);

map.display()

//let tag = map["laba"]?[0]["job"]
//print(">>>>>> \(tag)")

print(">>>>>>> DICT : \n \(String(describing: map.JSON))")
