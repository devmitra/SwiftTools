//
//  ViewController.swift
//  SwiftToolsMobile
//
//  Created by Pushan Mitra on 22/04/17.
//  Copyright © 2017 Pushan Mitra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dat: Data = try! Data(contentsOf: Bundle.main.url(forResource: "Sample2", withExtension: "xml")! )
        let map: XMLMap = XMLMap();
        map.parse(xmlData: dat);
        
        map.display()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

