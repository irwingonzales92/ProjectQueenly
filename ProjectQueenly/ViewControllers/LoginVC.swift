//
//  LoginVC.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 10/8/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import UIKit
import FCAlertView

class LoginVC: UIViewController
{

    @IBOutlet var loginWithFbButton: UIButton!
    
    let alert = FCAlertView()
    
    override func viewDidLoad()
    {
        self.alert.delegate = self as! FCAlertViewDelegate
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginWithFbBtnPressed(_ sender: Any)
    {
        
    }
    @IBAction func loginWithEmailBtnPressed(_ sender: Any)
    {
        self.alert.addTextField(withPlaceholder: "Email", andTextReturn: nil)
        self.alert.addTextField(withPlaceholder: "Password", andTextReturn: nil)
        self.alert.cornerRadius = 0.1
//        self.alert.colorScheme = UIColor(red: 95, green: 0, blue: 131, alpha: 1)
        
        self.alert.showAlert(inView: self,
                        withTitle: "Use Your Own Email",
                        withSubtitle: nil,
                        withCustomImage: nil,
                        withDoneButtonTitle: "Done",
                        andButtons: nil)
    }
    
    
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        // Done Button was Pressed, Perform the Action you'd like here.
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

extension LoginVC: FCAlertViewDelegate {
    private func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        print("\(title) : \(index)")
        
        if title == "OK"
        {
            // Perform Action for Button 1
        }
        else
        {
            // Perform Action for Button 2
        }
        
    }
    
    func fcAlertViewDismissed(_ alertView: FCAlertView) {
        print("Delegate handling dismiss")
    }
    
    func fcAlertViewWillAppear(_ alertView: FCAlertView) {
        print("Delegate handling appearance")
    }
}
