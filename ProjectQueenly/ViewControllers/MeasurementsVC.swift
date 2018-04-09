//
//  MeasurementsVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 4/9/18.
//  Copyright © 2018 Irwin Gonzales. All rights reserved.
//

import UIKit

class MeasurementsVC: UIViewController {
    
    var recievedGown = [String: Any]()

    var height = Int()
    var size = Int()
    var weight = Int()
    var bust = Int()
    var hip = Int()

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var dissmissVC: UIButton!
    
    @IBAction func dismissVCOnBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MeasurementsVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MeasurementsCell
        
        switch indexPath.row
        {
        case 0:
             cell?.paramLabel.text = "height"
             
             let hipValue = self.recievedGown["height"] as! Int
             let heightString = String(describing: hipValue)
             cell?.contentLabel.text = heightString
             return cell!
        case 1:
            
            let sizeValue = self.recievedGown["size"] as! Int
            let sizeString = String(describing: sizeValue)
            cell?.paramLabel.text = "Size"
            cell?.contentLabel.text = sizeString
            return cell!
        case 2:
            
            let hipValue = self.recievedGown["hip"] as! Int
            let hipString = String(describing: hipValue)
            cell?.paramLabel.text = "Hip"
            cell?.contentLabel.text = hipString
            return cell!
        case 3:
            
            let waistValue = self.recievedGown["waist"] as! Int
            let waistString = String(describing: waistValue)
            cell?.paramLabel.text = "Wasit"
            cell?.contentLabel.text = waistString
            return cell!
            
        case 4:
            let bustValue = self.recievedGown["bust"] as! Int
            let bustString = String(describing: bustValue)
            cell?.paramLabel.text = "Bust"
            cell?.contentLabel.text = bustString
            return cell!


        default:
            return UITableViewCell()
        }
    }
}
