//
//  ViewController.swift
//  APIFourSquare
//
//  Created by Viren Patel on 3/19/18.
//  Copyright © 2018 Viren Patel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate
{
    var Obj_Responce: response?
    var locationManager = CLLocationManager()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var Venues_tableview: UITableView!
    var cityname:String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SetUPLocationManager()
         title = "Venues"
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let loc = locations.last
        {
            locationManager.stopUpdatingLocation()
            getCityName(loc: loc)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
    

    func SetUPLocationManager()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func getCityName(loc: CLLocation)
    {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(loc){(placemarks, error) in
            if let placem = placemarks?.last
            {
                self.cityname = placem.locality!
            }
        }
    }
    @IBAction func BarButton(_ sender: Any)
    {
        let obj_LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        obj_LocationViewController.Obj_Responce = Obj_Responce
        self.navigationController?.pushViewController(obj_LocationViewController, animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if Obj_Responce == nil
        {
            return 0
        }
        else
        {
            return (Obj_Responce?.venues.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        guard let labeltext = Obj_Responce?.venues[indexPath.row].name else {
            return cell!
        }
        cell?.textLabel?.text = labeltext
        return cell!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        GetTabledata(serchbarStr: searchBar.text!)
        searchBar.resignFirstResponder()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        GetTabledata(serchbarStr: searchText)
    }
    func GetTabledata(serchbarStr: String)
    {
        WebServiceHandler.sharedInstance.getVenues(cityname: cityname.replacingOccurrences(of: " " , with: "+"), searchStr: serchbarStr){(ResponseDic, error) in
            if error == nil
            {
                self.Obj_Responce = ResponseDic!
                DispatchQueue.main.async
                {
                    self.Venues_tableview.reloadData()
                }
            }
        }
    }
    

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
