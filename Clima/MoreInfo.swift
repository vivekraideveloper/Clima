//
//  MoreInfo.swift
//  Clima
//
//  Created by Vivek Rai on 22/08/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class MoreInfo : UIViewController{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var visLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    var cityname : String = ""
    var high : Int = 0
    var low : Int = 0
    var humid : Int = 0
    var pressure : Int = 0
    var lat : Double = 0.0
    var lon : Double = 0.0
    var visibility : Int = 0
    var windSpeed : Double = 0
    
    
    override func viewDidLoad() {
        cityLabel.text = cityname
        highLabel.text = String(high)+"°"
        lowLabel.text = String(low)+"°"
        humidLabel.text = String(humid)+"%"
        pressureLabel.text = String(pressure)+"hPa"
        latLabel.text = String(lat)
        lonLabel.text = String(lon)
        visLabel.text = String(visibility)+"m"
        windLabel.text = String(windSpeed)+"Km/h"
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
