//
//  NewViewController.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (DistrictInfo?.info.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifire = "cell"
        
                var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire)
        
                if(cell == nil) {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifire)
                }
        
                cell?.textLabel?.text = DistrictInfo?.info[indexPath.row]
        
                return cell!
    }
    

    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = DistrictInfo?.title
        }
    }
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    var DistrictInfo: DistrictInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherGetter.getTempurature(latitude: (DistrictInfo?.latitude)!, longitude: (DistrictInfo?.longitude)!, completition: viewWeather)
        // Do any additional setup after loading the view.
    }
    
    func viewWeather(temperature:Double){
        self.weatherLabel.text = "Temperature: \(temperature)"
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
