//
//  ViewController.swift
//  DiviaHoraire
//
//  Created by esirem on 13/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //https://www.youtube.com/watch?v=8IBFuBgM09A
    
    
    //https://www.youtube.com/watch?v=fP69LI5bZlg
    var urlLink: String = ""
    
    var ligneItems: [Ligne]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchData()
    }

    func fetchData() {
        let homeParser = HomeParser()
        homeParser.parseFeed(url: "http://timeo3.keolis.com/relais/217.php?xml=1") {
            (ligneItems) in
            self.ligneItems = ligneItems
            
            print(self.ligneItems!)
        }        // video 25:56
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

