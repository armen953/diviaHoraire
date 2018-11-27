//
//  ViewController.swift
//  DiviaHoraire
//
//  Created by esirem on 13/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var homeTableView: UITableView!
    //https://www.youtube.com/watch?v=8IBFuBgM09A
    
    
    //https://www.youtube.com/watch?v=fP69LI5bZlg
    var urlLink: String = ""
    let identifier = "LigneCell"
    var ligneItems: [Ligne]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        homeTableView.dataSource = self
        
        fetchData()
    }

    func fetchData() {
        let homeParser = HomeParser()
        homeParser.parseFeed(url: "http://timeo3.keolis.com/relais/217.php?xml=1") { (ligneItems) in
            self.ligneItems = ligneItems
            
            print(ligneItems)
            
            OperationQueue.main.addOperation {
                self.homeTableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // check if ligneItems exist
        guard let ligneItems = ligneItems else {
            return 0
        }
        return ligneItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! LigneCell
            if let ligne =  ligneItems?[indexPath.row] {
                cell.ligneNameView.text = ligne.nom + " > " + ligne.vers
            }
        //cell.ligneNameView.text = "test" // ligne.nom
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showArrets" {
            let vc = segue.destination as! ArretsViewController
            let indexPath = homeTableView.indexPathForSelectedRow!
            let row = indexPath.row
            
            vc.ligneId = ligneItems![row].code
            vc.sense = ligneItems![row].sens
            vc.tempTitlename = ligneItems![row].nom + " > " + ligneItems![row].vers
        
        }
    }
}

