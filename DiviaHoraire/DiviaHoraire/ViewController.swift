//
//  ViewController.swift
//  DiviaHoraire
//
//  Created by esirem on 13/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    //https://www.youtube.com/watch?v=8IBFuBgM09A
    var urlLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        urlLink = "http://timeo3.keolis.com/relais/217.php?xml=1"
        guard let url = URL(string: urlLink) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            // Convert data to String
            var stringData: String = String(data: data, encoding: .ascii)!
            
            // Convert LF or CR
            stringData = stringData.replacingOccurrences(of: "\r", with: "\n")
            
            print(stringData)
            
            
            
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            if parser.parse() {
//               // print(self.results ?? "No results")
//            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

