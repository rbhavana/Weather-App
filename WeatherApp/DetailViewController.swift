//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Student on 12/7/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController
{
    var webView : WKWebView!
    var detailItem : [String : String]!
    
    override func loadView()
    {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        guard detailItem != nil else
        {
            return
        }
    }
}
