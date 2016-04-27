//
//  MainMenuViewController.swift
//  IT JobSearch
//
//  Created by ITHS on 2016-04-12.
//  Copyright © 2016 Oskar Jönsson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, DataSupportProtocol  {

    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    let dataSupport = DataSupport()
    let pickerData = ["Stockholm", "Uppsala", "Göteborg", "Malmö"]
    var adverts: [AnyObject]?
    
    func callBackDataSupport(dictionaryArray: [AnyObject]) -> () {
        adverts = dictionaryArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statePicker.dataSource = self
        statePicker.delegate = self
        
        dataSupport.getJobAdvertisementForCity(self, city: pickerData[statePicker.selectedRowInComponent(0)])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dataSupport.getJobAdvertisementForCity(self, city: pickerData[row])
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "JobAdSegue"){
            let nextView = segue.destinationViewController as! JobTableViewController
            nextView.adverts = adverts

        }
        
    }
    

}
