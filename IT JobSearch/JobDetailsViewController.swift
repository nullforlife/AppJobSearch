//
//  JobDetailsViewController.swift
//  IT JobSearch
//
//  Created by ITHS on 2016-04-12.
//  Copyright © 2016 Oskar Jönsson. All rights reserved.
//

import UIKit
import MapKit

class JobDetailsViewController: UIViewController, DataSupportProtocol2 {

    
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var lastDate: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var id: String?
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    let dataSupport = DataSupport()
    let initialLocation = CLLocation(latitude: 60.12816100000001, longitude: 18.643501000000015)
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSupport.getJobAdvertisementForId(self, id: id!)
        
        centerMapOnLocation(initialLocation)
        
        
    }
        
    func setMapLocation(adress: String, company: String, city: String) {
        //1
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = adress
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Kunde dessväre inte hitta platsen på kartan", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = company
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
        }
    }
    
    func callBackDataSupport(dictionaryArray: [String: AnyObject]) {

        let dict: [String: AnyObject] = dictionaryArray
        print(dict)
        dispatch_async(dispatch_get_main_queue()) {
            if let ad = dict["annons"] as? [String: AnyObject]{
                if let adTitle = ad["annonsrubrik"] as? String {
                    self.companyName.text = adTitle
                }
                if let adText = ad["annonstext"] as? String {
                    self.jobDescription.text = adText
                }
            }
            if let adRequest = dict["ansokan"] as? [String: AnyObject] {
                if let lastDate = adRequest["sista_ansokningsdag"] as? String {
                    self.lastDate.text = lastDate.substringWithRange(Range<String.Index>(start: lastDate.startIndex, end: lastDate.endIndex.advancedBy(-15)))
                }
                else{self.lastDate.text = "Ej angivet"}
            }
            if let workPlace = dict["arbetsplats"] as? [String: AnyObject]{
                if let company = workPlace["arbetsplatsnamn"] as? String {
                    if let address = workPlace["besoksadress"] as? String {
                        if let city = workPlace["besoksadress"] as? String {
                            self.setMapLocation(address, company: company, city: city)
                        }
                    }
                }
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
