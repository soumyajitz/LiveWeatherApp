//
//  ViewController.swift
//  LiveWeatherApp
//
//  Created by Soumyajit Sarkar on 2/4/16.
//  Copyright © 2016 Raul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textCity: UITextField!
    
    @IBOutlet var temp: UILabel!
    @IBOutlet var result: UILabel!
    @IBAction func searchWeather(sender: AnyObject) {
        var city = textCity.text!
        var cityname = city.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        if cityname == "" {
        
            result.text = "Please Enter Proper City Name"
        }
        else
        {
        let url = NSURL(string: "http://www.weather-forecast.com/locations/"+cityname+"/forecasts/latest")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                var webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                var webArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                // print(webArray)
                if webArray!.count > 0 {
                    let weather = webArray![1].componentsSeparatedByString("</span>")
                    if weather.count > 0 {
                        let summary = weather[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        var temperature = summary.componentsSeparatedByString("max ")
                        var maxTemp = temperature[1].componentsSeparatedByString("ºC")
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.result.text = summary
                            self.temp.text = "Max Temp : "+String(maxTemp[0]) + "ºC"
                            
                        })
                    }
                }
            }
            
        }
        task.resume()
    }
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

