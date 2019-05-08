//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by jp on 2019-05-07.
//  Copyright © 2019 Jordan Perrella. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
  
  // API CREDS
  let WEATHER_URL = ""
  let APP_ID = ""
  
  let locationManager = CLLocationManager()
  
    
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  
  //MARK: - Networking
  
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
  // MARK: - Location Manager Delegate Methods
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      print ("longitude =  \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
      
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      
      let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
      
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "Location Unavailable"
  }
  

}
