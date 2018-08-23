//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vivek Rai on 16/08/2018.

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "6c52cdc963ac68b3e4ea5a9ff7c848ca"
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url : String, parameters : [String : String]){
        Alamofire.request(url, method : .get, parameters : parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the weather data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json : weatherJSON)
                print(weatherJSON)
                
                
                
            }else{
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON) {
        if let temp = json["main"]["temp"].double{
            weatherDataModel.temperature = Int(temp - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            weatherDataModel.humidity = json["main"]["humidity"].intValue
            weatherDataModel.lat = json["coord"]["lat"].doubleValue
            weatherDataModel.lon = json["coord"]["lon"].doubleValue
            weatherDataModel.temp_min = Int(json["main"]["temp_min"].doubleValue - 273.15)
            weatherDataModel.temp_max = Int(json["main"]["temp_max"].doubleValue - 273.15)
            weatherDataModel.pressure = json["main"]["pressure"].intValue
            weatherDataModel.visibility = json["visibility"].intValue
            weatherDataModel.windSpeed = json["wind"]["speed"].doubleValue
            
            
            
            
            updateUIWithWeatherData()
        }else{
            cityLabel.text = "Weather Unavailable"
        }
       
        
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("Longitude = \(location.coordinate.longitude) and Latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url : WEATHER_URL, parameters : params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredCityName(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
        
        if segue.identifier == "moreInfo" {
            let moreinfoVC = segue.destination as! MoreInfo
            moreinfoVC.cityname = cityLabel.text!
            moreinfoVC.high = weatherDataModel.temp_max
            moreinfoVC.low = weatherDataModel.temp_min
            moreinfoVC.humid = weatherDataModel.humidity
            moreinfoVC.pressure = weatherDataModel.pressure
            moreinfoVC.lat = weatherDataModel.lat
            moreinfoVC.lon = weatherDataModel.lon
            moreinfoVC.visibility = weatherDataModel.visibility
            moreinfoVC.windSpeed = weatherDataModel.windSpeed
            
            
        }
    }
    @IBAction func moreInfoButton(_ sender: Any) {
       performSegue(withIdentifier: "moreInfo", sender: self)
    }
    
    
    
    
    
    
    
}


