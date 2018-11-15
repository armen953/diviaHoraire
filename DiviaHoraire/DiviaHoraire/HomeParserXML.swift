//
//  HomeParserXML.swift
//  DiviaHoraire
//
//  Created by esirem on 15/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import Foundation

struct Ligne {
    var code: String
    var nom: String
    var sens: String
    var vers: String
}

class HomeParser: NSObject, XMLParserDelegate{
    
    var ligneItems: [Ligne] = []
    private var currentElement = ""
    
    private var currentCode: String = "" {
        didSet {
            currentCode = currentCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentNom: String = "" {
        didSet {
            currentNom = currentNom.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentSens: String = "" {
        didSet {
            currentSens = currentSens.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentVers: String = "" {
        didSet {
            currentVers = currentVers.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler:(([Ligne]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([Ligne]) -> Void)?){
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
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("end")
        parserCompletionHandler?(ligneItems)
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("start")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "ligne" {
            currentNom = ""
            currentCode = ""
            currentVers = ""
            currentSens = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "code": currentCode += string
            case "nom": currentNom += string
            case "sens": currentSens += string
            case "vers": currentVers += string
            default: break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "ligne" {
            let ligneIterm = Ligne(code: currentCode, nom: currentNom, sens: currentSens, vers: currentVers)
            self.ligneItems.append(ligneIterm)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
