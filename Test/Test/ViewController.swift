//
//  ViewController.swift
//  Test
//
//  Created by Samuel Wairegi on 31/03/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var jsonData :[Dictionary<String, AnyObject>] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let request = NSURLRequest(URL: NSURL(string: "https://datatank.stad.gent/4/toerisme/visitgentspots.json")!)
        
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
               do {
                
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                
                self.jsonData = jsonResult as! [Dictionary<String, AnyObject>]
                self.tableView!.reloadData()
                    
                } catch let error as NSError {
                    
                    print(error)
                    
                }
        
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // number of rows in table view
     func tableView(_tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TableCell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TableCell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
         let anItem = self.jsonData[indexPath.row]
            let title = anItem["title"] as! String
        
        cell!.textLabel?.text = title
        
         load_image(anItem["thumbs"] as! String, view:cell!.imageView!)
        
        
        return cell!
    }
    
    
    func load_image(image_url_string:String, view:UIImageView)
    {
        
        let image_url: NSURL = NSURL(string: image_url_string)!
        let image_from_url_request: NSURLRequest = NSURLRequest(URL: image_url)
        
        NSURLConnection.sendAsynchronousRequest(
            image_from_url_request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse?,
                data: NSData?,
                error: NSError?) -> Void in
                
                if error == nil && data != nil {
                    view.image = UIImage(data: data!)
                }
                
        })
        
    }
}

