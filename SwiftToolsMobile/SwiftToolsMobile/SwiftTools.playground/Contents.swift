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

extension String {
    func match(_ other: String) -> Bool {
        
        
        if self == other {
            return true
        }
        
        let thiswords: [String] = self.components(separatedBy: " ")
        let thatwords: [String] = other.components(separatedBy: " ")
        
        let bigword: [String] = thiswords.count > thatwords.count ? thiswords : thatwords
        let smallword: [String] = thiswords.count <= thatwords.count ? thiswords : thatwords
        
        for word in smallword {
            if let _ = bigword.index(of: word) {
                continue
            }
            else {
                return false
            }
        }
        
        
        return true
    }
}

var s1: String = "labak bhalo chele"
var s2: String = "labak"
s1.match(s2)
