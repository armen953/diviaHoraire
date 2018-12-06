//
//  HoraireParserXML.swift
//  DiviaHoraire
//
//  Created by esirem on 27/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import Foundation


struct Horaire {
    var duree: String
    var destination: String
}

class HoraireParser: NSObject, XMLParserDelegate {
    var horaireItems: [Horaire] = []
    private var currentElement = ""
    
    private var currentDuree: String = "" {
        didSet {
            currentDuree = currentDuree.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentDestination: String = "" {
        didSet {
            currentDestination = currentDestination.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler:(([Horaire]) -> Void)?

    
    func parseFeed(url: String, completionHandler: (([Horaire]) -> Void)?){
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("start")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("end")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print(elementName)
        if currentElement == "passage" {
            currentDuree = ""
            currentDestination = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "duree": currentDuree += string
            case "destination": currentDuree += string
            default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let horaireItem = Horaire(duree: currentDuree, destination: currentDestination)
        self.horaireItems.append(horaireItem)
        //print(horaireItem)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
