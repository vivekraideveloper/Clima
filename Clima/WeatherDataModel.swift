//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Vivek Rai on 16/08/2018.
//

import UIKit

class WeatherDataModel {

    //Declare your model variables here
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    var humidity : Int = 0
    var temp_min : Int = 0
    var temp_max : Int = 0
    var pressure : Int = 0
    var lat : Double = 0.0
    var lon : Double = 0.0
    var windSpeed : Double = 0
    var visibility : Int = 0
    
    
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"

        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }

    }
}
