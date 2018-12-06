//
//  ArretsViewController.swift
//  DiviaHoraire
//
//  Created by esirem on 22/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import UIKit

class ArretsViewController: UIViewController, UITableViewDataSource {


    var ligneId = String()
    var sense = String()
    let identifier = "ArretCell"
    
   
    var arretsItems: [Arret]?
    
    var tempTitlename = String()
    @IBOutlet weak var arretsTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    //http://timeo3.keolis.com/relais/217.php?xml=1&ligne=T1&sens=A
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arretsTableView.dataSource = self
        navigationTitle.title = tempTitlename
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let arretParser = ArretParser()
        arretParser.parseFeed(url: "http://timeo3.keolis.com/relais/217.php?xml=1&ligne=\(ligneId)&sens=\(sense)") { (arretsItems) in
            self.arretsItems = arretsItems
            //print(self.arretsItems)
            OperationQueue.main.addOperation {
                self.arretsTableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arretsItems = arretsItems else {
            return 0
        }
        return arretsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ArretsCell
        if let arret =  arretsItems?[indexPath.row] {
            cell.arretName.text = arret.nom
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showHoraire" {
            let vc = segue.destination as! HoraireViewController
            let indexPath = arretsTableView.indexPathForSelectedRow!
            let row = indexPath.row
            print(arretsItems![row].refs)
            vc.refs = arretsItems![row].refs
            vc.code = arretsItems![row].code
            vc.nom = arretsItems![row].nom
            vc.ligne = ligneId
        }
    }
    
}
