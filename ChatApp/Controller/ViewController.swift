//
//  ViewController.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/10/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var txtname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: ----- ACTION METHOD -------
    @IBAction func btnLoginAaction(_ sender: Any) {
        
        if !((txtname.text?.isEmpty)!) && !(txtname.text?.contains(find:" "))!
        {
            login()
        }
        else{
            
            SingletonClass.sharedInstance.showAlertView(title: "Error", message: "Blank or Invalid Input", viewC: self)
        }
    }
    
    func login()
    {
        let param : [String:AnyObject] = ["Name": txtname.text! as AnyObject]

        Webservice.sharedInstance.postMethodRequest(Helper.URLs.BaseURL+Helper.URLs.userLogin, param: param, view: self.view) { (response) in
            
            guard response.result.error == nil else {
                print("error calling api")
                print(response.result.error!)
                return
            }
            
            //print(response.result.value as? [String: Any])
            
            
            guard let json = response.result.value as? [String: Any] else {
                //print("didn't get todo object as JSON from API")
                //print("Error: \(response.result.error)")
                return
            }
            
            guard let id = json["id"] as? Int, let name = json["name"] as? String, let token = json["token"] as? String else{
                return
            }
            
            SingletonClass.sharedInstance.token = token
            SingletonClass.sharedInstance.id = "\(id)"
            SingletonClass.sharedInstance.name = name
            self.pushController()
        }
    }
    
    func pushController()
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userListVC : UserListViewController = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(userListVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	

}

