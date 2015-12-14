//
//  ViewController.swift
//  WebServicesExample2
//
//  Created by Vince Day on 12/9/15.
//  Copyright © 2015 Vince Day. All rights reserved.
//

import UIKit
import SwiftyJSON




class ViewController: UIViewController {
    

    @IBOutlet weak var forecastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = JSON(responseObject)
        if let forecast = json["list"][0]["weather"][0]["description"].string {
            self.forecastLabel.text = forecast
        }
        
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=62371582211be3320c39fc6f1835e84b", parameters: nil,
            progress: { (progress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                print("JSON: " + responseObject!.description)
                if let listOfDays = responseObject!["list"] as? NSArray {
                    if let tomorrow = listOfDays[0] as? NSDictionary {
                        if let tomorrowsWeather = tomorrow["weather"] as? NSArray {
                            if let firstWeatherOfDay = tomorrowsWeather[0] as? NSDictionary {
                                if let forecast = firstWeatherOfDay["description"] as? String {
                                    self.forecastLabel.text = forecast
                                }
                            }
                        }
                    }
                }
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error: " + error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

