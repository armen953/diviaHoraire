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
    var ligne = String() // ligne code
    
    var horairesItems: [Horaire]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(refs)
        //print(code)
        print(nom)
        print(ligne)
        fetchData()
        // http://timeo3.keolis.com/relais/217.php?xml=3&ran=1&refs=274433027|274433539|274434307
    }
    
    func fetchData() {
        let horaireParser = HoraireParser()
        horaireParser.parseFeed(url: "http://timeo3.keolis.com/relais/217.php?xml=3&ran=1&refs=\(refs)")
        { (horairesItems) in
            self.horairesItems = horairesItems
            //print(self.horairesItems!)
            OperationQueue.main.addOperation {
                //self.arretsTableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
