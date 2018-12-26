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
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var ligneLabel: UILabel!
    
    @IBOutlet weak var passage1Label: UILabel!
    @IBOutlet weak var passage2Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(refs)
        //print(code)
        print(nom)
        print(ligne)
        nomLabel.text = nom
        ligneLabel.text = ligne
        fetchData()
     
        // http://timeo3.keolis.com/relais/217.php?xml=3&ran=1&refs=274433027|274433539|274434307
    }
    
    func fetchData() {
        let horaireParser = HoraireParser()
        horaireParser.parseFeed(url: "http://timeo3.keolis.com/relais/217.php?xml=3&ran=1&refs=\(refs)")
        { (horairesItems) in
            self.horairesItems = horairesItems
            print(self.horairesItems!)
            print(self.horairesItems!.count)
            OperationQueue.main.addOperation {
                if self.horairesItems!.isEmpty {
                    self.setPassage1ToNull()
                    self.setPassage2ToNull()
                } else {
                    if self.horairesItems!.count == 1 {
                        self.passage1Label.text = self.horairesItems![0].duree
                    }else if self.horairesItems!.count == 2 {
                        self.passage1Label.text = self.horairesItems![0].duree
                        self.passage2Label.text = self.horairesItems![1].duree
                    }else {
                        self.setPassage1ToNull()
                        self.setPassage2ToNull()
                    }
                }
            }
        }
    }

    func setPassage1ToNull() {
        self.passage1Label.text = "Pas de passage !"
    }
    
    func setPassage2ToNull() {
        self.passage2Label.text = "Pas de passage !"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
