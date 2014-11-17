//
//  CurrencyXml.swift
//  xmlParser
//
//  Created by Kevin Brejcha on 2014-11-13.
//  Copyright (c) 2014 Kevin Brejcha. All rights reserved.
//

import Foundation
import CoreData

class CurrencyXml: NSObject, NSXMLParserDelegate  {
    
    var cleanXml: [String : Double] = [:]
    var xmlDate: String = ""
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        //println("Element's name is \(elementName)")
        //println("Element's attributes are \(attributeDict)")

        var temp: String = ""
        
        if(elementName == "Cube"){
            
            var time = attributeDict["time"] as String!
            var currency = attributeDict["currency"] as String!
            var rate = attributeDict["rate"] as String!
            
            //Take out the timestamp and put in variable
            if let test1 = time{
                xmlDate = attributeDict["time"] as String!
            }
            
            if let test = currency{

                //String in currency
                let var1 = attributeDict["currency"] as String!
                
                //String in rate
                let var2 = attributeDict["rate"] as String!
                
                //Convert rate string to NSString and then do double
                let doubleParse = (var2 as NSString).doubleValue
                
                //temp = "\(var1) : \(doubleParse)"
                
                //Insert countrycode containing the rate i.e cleanXml["SEK"] = 9.2376
                cleanXml[var1] = doubleParse
            }
            //println(temp)
        }
        
    }
    
    func initXml(){
        
        var url = NSURL(string: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
        
        //Parsin process
        var xmlParser = NSXMLParser(contentsOfURL: url)
        xmlParser!.delegate = self
        
        //Returns true if success
        if(xmlParser!.parse()){
            println("Success in parsing")
        }else{
            println("Parse failed!!!")
        }
    }
    
}

