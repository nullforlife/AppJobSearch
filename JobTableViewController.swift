//
//  JobTableViewController.swift
//  IT JobSearch
//
//  Created by ITHS on 2016-04-12.
//  Copyright © 2016 Oskar Jönsson. All rights reserved.
//

import UIKit

class JobTableViewController: UITableViewController {

    var adverts: [AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adverts!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! JobCellTableViewCell
        // Configure the cell...
        if let dict = adverts![indexPath.row] as? [String: AnyObject]{
            
            if let headline = dict["annonsrubrik"] as? String {
                cell.advertisementHeadline.text = headline
            }else{print("headline error")}
            
            if let workPlace = dict["arbetsplatsnamn"] as? String {
                cell.companyName.text = workPlace
            }else{print("workplace error")}
            
            if let datePublished = dict["publiceraddatum"] as? String {
                let dpEdited = datePublished.substringWithRange(Range<String.Index>(start: datePublished.startIndex, end: datePublished.endIndex.advancedBy(-15)))
                cell.datePublished.text = dpEdited
            }else{print("datepublished error")}
            
            if let id = dict["annonsid"] as? String {
                cell.id = id
            }else{print("id error")}
        
        }else{
            print("Couldn't retrieve value")
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "JobDetailSegue"){
            let jobDetail = segue.destinationViewController as! JobDetailsViewController
            let cell = sender as! JobCellTableViewCell
            jobDetail.id = cell.id
            
            
        }
        
        
    }
 

}
