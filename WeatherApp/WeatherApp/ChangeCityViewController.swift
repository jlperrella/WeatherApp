//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by jp on 2019-05-07.
//  Copyright © 2019 Jordan Perrella. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
  func userEnteredANewCityName (city : String)
}

class ChangeCityViewController: UIViewController {
  
  var delegate : ChangeCityDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  @IBOutlet weak var cityTextField: UITextField!
  
  @IBAction func getWeatherPressed(_ sender: AnyObject) {
    
    let cityName = cityTextField.text!
    
    delegate?.userEnteredANewCityName(city: cityName)
    
    self.dismiss(animated: true, completion: nil)
  
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
    print("backButton Pushed")
  }
  
}
