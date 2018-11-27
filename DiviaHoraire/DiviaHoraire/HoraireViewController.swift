//
//  HoraireViewController.swift
//  DiviaHoraire
//
//  Created by esirem on 27/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import UIKit

class HoraireViewController: UIViewController {

    var refs = String()
    var code = String()
    var nom = String()
    
    var horairesItems: [Horaire]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(refs)
        print(code)
        print(nom)
        fetchData()
    }
    func fetchData() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
