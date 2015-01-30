//
//  ViewController.swift
//  Get the Weather
//
//  Created by Mat Sletten on 10/23/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
                            
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var forecastResultLabel: UILabel!
    @IBAction func searchButton(sender: AnyObject)
    {
        self.view.endEditing(true)
        var urlString = "http://www.weather-forecast.com/locations/" + searchTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest"
        
        var url = NSURL (string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url)
            {
                (data, response, error) in
                var urlContent = (NSString(data: data, encoding:NSUTF8StringEncoding))
                let tempUrlContent: String = urlContent as String
                if (tempUrlContent._bridgeToObjectiveC().containsString("<span class=\"phrase\">"))
                {
                var contentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                var endContentArray = contentArray[1].componentsSeparatedByString("</span>")
                
                //use the code below to improve how fast the label updates
                dispatch_async(dispatch_get_main_queue())
                    {
                        self.forecastResultLabel.text = endContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as String
                    }
                }
                else
                {
                dispatch_async(dispatch_get_main_queue())
                    {
                    self.forecastResultLabel.text = "Location Not Found"
                    }
                }
            }
            task.resume()
        //println(urlString)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

