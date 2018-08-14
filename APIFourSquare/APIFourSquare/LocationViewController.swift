//
//  LocationViewController.swift
//  APIFourSquare
//
//  Created by Viren Patel on 3/19/18.
//  Copyright © 2018 Viren Patel. All rights reserved.
//

import UIKit
import MapKit
class LocationViewController: UIViewController
{
    var Obj_Responce: response?
    
    @IBOutlet weak var mapkitApple: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetUpMap()
    {
        var arrdropins : Array<MKPointAnnotation> = []
        let centerloc = CLLocation(latitude: (Obj_Responce?.venues[0].location.lat)!, longitude: (Obj_Responce?.venues[0].location.lng)!)
        for item in (Obj_Responce?.venues)!
        {
            let loc = CLLocation(latitude: item.location.lat!, longitude: item.location.lng!)
            let dropin = MKPointAnnotation()
            dropin.coordinate = loc.coordinate
            dropin.title = item.name
            arrdropins.append(dropin)
        }
        mapkitApple.addAnnotations(arrdropins)
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegion(center: centerloc.coordinate, span: span)
        mapkitApple.setRegion(region, animated: true)
        
        
    }
    
    func whatIsMyName(name: String) -> String{
        return name.replacingOccurrences(of: " ", with: "")
    }
}
