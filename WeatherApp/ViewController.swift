//
//  ViewController.swift
//  WeatherApp
//
//  Created by Student on 12/6/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var myTableView: UITableView!

    var cities = [[String: String]]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let urlString = "http://api.wunderground.com/api/3e2a46891865d1bc/conditions/q/IL/Chicago.json"
        if let url = NSURL(string: urlString)
        {
            if let myData = try? NSData(contentsOf: url as URL, options: [])
            {
                let json = JSON(data: myData as Data)
                parse(json: json)
                print("ok to parse")
            }
        }
    }
    
        func parse(json: JSON)
        {
            for result in json["current_observation"].arrayValue
            {
                let city = result["city"].stringValue
                let state = result["state"].stringValue
                let temperaturef = result["temp_f"].stringValue
                let temperaturec = result["temp_c"].stringValue
                
                let object = ["city": city, "state": state, "tempe_f": temperaturef, "temp_c": temperaturec]
                
                cities.append(object)
            }
            myTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        
        let city = cities[indexPath.row]
        cell.textLabel?.text = city["city"]
        cell.detailTextLabel?.text = city["temp_f"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = myTableView.indexPathForSelectedRow
        {
            let city = cities[indexPath.row]
            let nextController = segue.destination as! DetailViewController
            nextController.detailItem = city
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any)
    {
        alert()
    }
    
    func save()
    {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: cities)
        
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "cities")
    }
    
    func alert()
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "City name"
            
        let addAction = UIAlertAction(title: "Add", style: .default)
            { (addAction) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                
                self.myTableView.reloadData()
                self.save()
            }
            alert.addAction(addAction)
        }
        
        self.present(alert, animated: true, completion: nil)
        self.save()
    }
}
    































