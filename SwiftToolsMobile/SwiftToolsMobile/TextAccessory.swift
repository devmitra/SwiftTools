////
////  TextAccessory.swift
////  SwiftToolsMobile
////
////  Created by Pushan Mitra on 25/05/17.
////  Copyright © 2017 Pushan Mitra. All rights reserved.
////
//
//import UIKit
//
//
//public class Accessory: NSObject {
//    var doneButton: UIBarButtonItem?
//    var clearButton: UIBarButtonItem?
//    var toolBar: UIToolbar?
//    var lable: UILabel?
//}
//
//@objc
//protocol TextAccessory {
//    func setup() -> Accessory
//    @objc func doneAction(_ sender:Any?)
//    @objc func clearAction(_ sender:Any?)
//    
//    var doneButton: UIBarButtonItem {get}
//    var clearButton: UIBarButtonItem {get }
//    var textLabel: UILabel {get}
//    var toolbar: UIToolbar {get}
//}
//
//extension TextAccessory {
//    func setup() -> Accessory {
//        
//        // DoneButton
//        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
//        
//        // Clear Button
//        let clearButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clearAction(_:)))
//        
//        // Left Flexi space
//        let spacer1: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        
//        // Right Flexi space
//        let spacer2: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        
//        // Label
//        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40));
//        
//        // Text
//        let text: UIBarButtonItem = UIBarButtonItem(customView: label);
//        
//        
//        
//        let toolBar: UIToolbar = UIToolbar();
//        toolBar.barStyle = .blackTranslucent;
//        
//        toolBar.items = [clearButton, spacer1, text, spacer2, doneButton]
//        
//        let acc: Accessory = Accessory();
//        acc.doneButton = doneButton
//        acc.clearButton = clearButton
//        acc.toolBar = toolBar
//        acc.lable = label
//        
//        return acc;
//        
//    }
//    
//    func doneAction(_ sender:Any?){}
//    func clearAction(_ sender:Any?){}
//}
//
//@IBDesignable
//public class TextFieldWithAccessory : UITextField {
//    
//}
//
//extension TextFieldWithAccessory: TextAccessory {
//    
//
//    
//}
//
//
