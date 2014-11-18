//
//  ViewController.swift
//  xmlParser
//
//  Created by Kevin Brejcha on 2014-11-11.
//  Copyright (c) 2014 Kevin Brejcha. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //Variables
    @IBOutlet weak var fromCurrency: UIPickerView!
    @IBOutlet weak var toCurrency: UIPickerView!
    
    @IBOutlet weak var currencyValue: UITextField!
    @IBOutlet weak var convertedCurrency: UILabel!

    @IBOutlet weak var labelHello: UILabel!
    
    @IBOutlet weak var fromRate: UILabel!
    @IBOutlet weak var toRate: UILabel!

    
    //var currencyArray = ["Hej","Hello","Hola","Hallo","Moi","Zdravo"]
    
    //Currency Array to fick pickerView
    var currencyA: [String] = []
    
    var xmlData: CurrencyXml!
    
    var currencyDict: [String : Double] = [:]
    
    var dbCurrency: [Forex]! = []
    var dbTime: [Updated]! = []
    
    var fromRateValue: Double = 0
    var toRateValue: Double = 0
    
    //var managedContext: NSManagedObjectContext!
    
    var coreDataStack: CoreDataStack!
    
    var currentCurrency: Forex!
    
    //SVariabler
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        fromCurrency.delegate = self
        toCurrency.delegate = self
        fromCurrency.dataSource = self
        toCurrency.dataSource = self
        
        //Skapar ett objekt av XML och kör initieringen som laddar ner all data
        xmlData = CurrencyXml()
        xmlData.initXml(coreDataStack)
        
        //currencyDict = xmlData.cleanXml
        
        //Write out the date the xmldata is from
        labelHello.text = xmlData.xmlDate
        
        //populate array from dictionary
        for currency in currencyDict.keys{
            currencyA.append(currency)
        }
        
        //xmlData.importXMLData(coreDataStack, data: currencyA)
        
        //Test kod
        
        /*let currencyFetch = NSFetchRequest(entityName: "Forex")
        var error: NSError?
        let result = coreDataStack.context.executeFetchRequest(currencyFetch, error: &error) as [Currency]?
        
        if let currencies = result {
            
            println("Nr of entries: \(currencies.count)")
            
            if currencies.count == 0 {
                
                //xmlData.importXMLData(coreDataStack, data: currencyA)
                
            } else {
                currentCurrency = currencies[0]
                println("Currency: \(currencies)")
            }
            
        } else {
            
            println("Could not fetch: \(error)")
            
        }*/
    
    }
    
    //This method is used when convertvalue is changed
    @IBAction func valueChanged(sender: AnyObject) {
        calculateCurrency()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyA.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.isEqual(fromCurrency)){
            
            fromRate.text = String(format:"%f", currencyDict[currencyA[row]]!)
            fromRateValue = currencyDict[currencyA[row]]!
            
        }
        if(pickerView.isEqual(toCurrency)){
            
            toRate.text = String(format:"%f", currencyDict[currencyA[row]]!)
            toRateValue = currencyDict[currencyA[row]]!
            
        }
        
        calculateCurrency()

    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return currencyA[row]
    }
    
    //Function to calculate the correct value and update all values
    func calculateCurrency(){
        
        //Convert rate string to NSString and then do double
        let doubleParse = (currencyValue.text as NSString).doubleValue
        
        var result: Double = ((doubleParse / fromRateValue) * toRateValue)
        
        convertedCurrency.text = String(format:"%f", result)
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
}

