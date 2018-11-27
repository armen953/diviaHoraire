//
//  ArretsParserXML.swift
//  DiviaHoraire
//
//  Created by esirem on 22/11/2018.
//  Copyright © 2018 esirem. All rights reserved.
//

import Foundation

struct Arret {
    var code: String
    var nom: String
    var refs: String
}

class ArretParser: NSObject, XMLParserDelegate {
    
    var arretsItems: [Arret] = []
    private var currentElement = ""
    private var isArret = false
    
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
    
    private var currentRefs: String = "" {
        didSet {
            currentRefs = currentRefs.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler:(([Arret]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([Arret]) -> Void)?){
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
        parserCompletionHandler?(arretsItems)
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("start")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "als" {
            currentNom = ""
            currentCode = ""
            currentRefs = ""
        }
        if elementName == "arret" || elementName == "refs" {
            isArret = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isArret {
            switch currentElement {
            case "code": currentCode += string
            case "nom": currentNom += string
            case "refs": currentRefs += string
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "arret" || elementName == "refs"  {
            isArret = false
        }
        if elementName == "als"  {
            let arretItem = Arret(code: currentCode, nom: currentNom, refs: currentRefs)
            self.arretsItems.append(arretItem)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    
    
    
}
