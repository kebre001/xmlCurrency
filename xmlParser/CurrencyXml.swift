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
    var currencyArray: [String] = []
    
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
                
                
                //println("var1: \(var1) , doubleParse: \(doubleParse)")
                
                
                cleanXml[var1] = doubleParse
            }
            //println(temp)
        }
        
    }
    
    func loadAllEntities(coreDataStack: CoreDataStack){
        let currencyFetch = NSFetchRequest(entityName: "Forex")
        var error: NSError?
        let result = coreDataStack.context.executeFetchRequest(currencyFetch, error: &error) as [Forex]?
        
        if let currencies = result {
            println("\(currencies.count)")
            if currencies.count == 0{
                println("000000000000")
            }else{
                println("111111111111")
                println("\(currencies)")
                println("\(currencies[0].country)")
            }
        }
    }
    
    //Uses a dictionary to parse all the files into the DB
    func parseToFile(coreDataStack: CoreDataStack, data: [String:Double]){
        
        for(countryDict, rateDict) in data {
            let currencyEntity = NSEntityDescription.entityForName("Forex", inManagedObjectContext: coreDataStack.context)
            
            let currency = Forex(entity: currencyEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            currency.country = countryDict
            currency.rate = rateDict
        }
        coreDataStack.saveContext()
        
    }
    
    //Uses a array to parse all data into the DB
    func importXMLData(coreDataStack: CoreDataStack, data: [String]){
        //  println(currencyDict.count)
        for var i = 0; i < data.count; ++i{
            let currencyEntity = NSEntityDescription.entityForName("Forex", inManagedObjectContext: coreDataStack.context)
            
            let currency = Forex(entity: currencyEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            var var1: String = data[i]
            var var2: Double = cleanXml[data[i]]!
            
            println("var1: \(var1), var2: \(var2)")
            
            currency.country = var1
            currency.rate = var2
        }
        
        coreDataStack.saveContext()
    }
    
    func copyDictToArray(){
        for currency in cleanXml.keys{
            currencyArray.append(currency)
        }
    }
    
    func initXml(coreDataStack: CoreDataStack){
        
        var url = NSURL(string: "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
        
        //Parsin process
        var xmlParser = NSXMLParser(contentsOfURL: url)
        xmlParser!.delegate = self
        
        //Returns true if success
        if(xmlParser!.parse()){
            println("Success in parsing")
            copyDictToArray()
            
            importXMLData(coreDataStack, data: currencyArray)
            loadAllEntities(coreDataStack)
            
            //println(cleanXml)
        }else{
            println("Parse failed!!!")
        }
    }
    
}

