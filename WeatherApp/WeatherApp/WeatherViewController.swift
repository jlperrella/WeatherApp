//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by jp on 2019-05-07.
//  Copyright © 2019 Jordan Perrella. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
  
  // API CREDS
  let WEATHER_URL = ""
  let APP_ID = ""
  
  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()
  
    
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
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "changeCityName"{
      let destinationVC = segue.destination as! ChangeCityViewController
      destinationVC.delegate = self
    }
    
  }
  
  
  //MARK: - Networking
  
  func getWeatherData(url: String, parameters: [String: String]){
    
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
      response in
      if response.result.isSuccess{
        print("Weather Data Recieved")
        let weatherJSON : JSON = JSON(response.result.value!)
        
        print(weatherJSON)
        self.updateWeatherData(json: weatherJSON)
        
      } else {
        print("Error \(String(describing: response.result.error))")
        self.cityLabel.text = "Network Error!"
      }
    }
    
  }
  
  // MARK: - Parse JSON
  
  func updateWeatherData(json : JSON){
    
    if let tempResult = json["main"]["temp"].double{
    weatherDataModel.temperature = Int(tempResult - 273.15)
    weatherDataModel.city = json["name"].stringValue
    weatherDataModel.condition = json["weather"][0]["id"].intValue
    weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
    updateUIWithWeatherData()
      
    } else{
      cityLabel.text = "weather unavailable"
    }
  }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
  
  // MARK: - UI
  
  func updateUIWithWeatherData(){
    cityLabel.text = weatherDataModel.city
    tempLabel.text = String(weatherDataModel.temperature) + "°"
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  
  // MARK: - Change City Delegate
  
  func userEnteredANewCityName(city: String) {
    print(city + " SELECTED")
  }
  
  
  // MARK: - Location Manager Delegate Methods
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      
      //Stops updating location after first call
      locationManager.delegate = nil
      
      print ("longitude =  \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
      
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
      getWeatherData(url: WEATHER_URL, parameters: params)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "Location Unavailable"
  }
  

}
