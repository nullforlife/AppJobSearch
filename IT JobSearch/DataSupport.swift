//
//  DataSupport.swift
//  IT JobSearch
//
//  Created by ITHS on 2016-04-12.
//  Copyright © 2016 Oskar Jönsson. All rights reserved.
//

import Foundation

class DataSupport{
    
    func getJobAdvertisementForId(sender: DataSupportProtocol2, id: String) {
        let string :String = "http://api.arbetsformedlingen.se/af/v0/platsannonser/\(id)"
        let utf8url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let urlPath = utf8url! as String
        
        let requestURL: NSURL = NSURL(string: urlPath)!
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let matchingData = json as? [String: AnyObject] {
                        if let ad = matchingData["platsannons"] as? [String: AnyObject]{
                            sender.callBackDataSupport(ad)
                        }
                    }
                    
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getJobAdvertisementForCity(sender: DataSupportProtocol, city: String) {
        
        let string :String = "http://api.arbetsformedlingen.se/af/v0/platsannonser/matchning?nyckelord=apputvecklare \(city)"
        let utf8url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let urlPath = utf8url! as String

        let requestURL: NSURL = NSURL(string: urlPath)!
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    //print(json["matchningslista"])
                    
                    if let matchingData = json as? [String: AnyObject] {
                        if let matchingList = matchingData["matchningslista"] as? [String: AnyObject]{
                            //print(matchingList["matchningdata"])
                            if let dict = matchingList["matchningdata"] as? [AnyObject]{
                                //print(dict)
                                sender.callBackDataSupport(dict)
                            }
                            
                        }
                        
                    
                    }
                    
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }
    
}


































