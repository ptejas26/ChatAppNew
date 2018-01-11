//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/10/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    
    @IBOutlet var txtMessage: UITextField!
    
    @IBOutlet var lblUserName: UILabel!
    
    var userID : String = ""
    
    var userName : String = ""
    
    var arrayOfChats : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = userName
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 100
        
        webserviceToFetchListOfChats()
    }
    

    func webserviceToFetchListOfChats()
    {
        Webservice.sharedInstance.getMethodRequest(Helper.URLs.BaseURL+Helper.URLs.userChatWithExistingUser+"\(userID)", view: self.view) { (response) in
            
            guard response.result.error == nil else {
                //print("error calling api")
                //print(response.result.error!)
                return
            }
            
            //print(response.result.value as? [AnyObject])
            guard let json = response.result.value as? [AnyObject] else {
                //print("didn't get todo object as JSON from API")
                //print("Error: \(response.result.error ?? <#default value#>)")
                return
            }
            
            self.arrayOfChats = json
            self.chatTableView.reloadData()
            if self.arrayOfChats.count > 0
            {
                let indexPath = IndexPath(row: self.arrayOfChats.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                self.txtMessage.text = ""
            }
            else{
                SingletonClass.sharedInstance.showAlertView(title: "Info", message: "Please try sending message again", viewC: self)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendAction(_ sender: Any) {
       
        if !((txtMessage.text?.isEmpty)!){
            webserviceToSendMessage()
        }
    }
    
    func webserviceToSendMessage()
    {
        /*
         
         {
         "message": "May the Force be with you."
         "toUserId": 2
         }
         
         */

        let parameter = ["Message":txtMessage.text ?? "no data", "toUserId":"\(userID)"] as [String : Any]
        
        Webservice.sharedInstance.postMethodRequest(Helper.URLs.BaseURL+Helper.URLs.userChat, param: parameter as [String : AnyObject], view: self.view) { (response) in
            
            self.webserviceToFetchListOfChats()
            
            
            guard response.result.error == nil else {
                print("error calling api")
                print(response.result.error!)
                return
            }
            
            print(response.result.value as? [String: Any])
            
            
            
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            
            guard let id = json["id"] as? Int, let name = json["name"] as? String, let token = json["token"] as? String else{
                return
            }
        }
    }
}
extension ChatViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        /*
         {
         createdDateTime = "2018-01-10T22:29:11.3768788";
         fromUserId = 2070;
         id = 3285;
         message = hi;
         toUserId = 1;
         }
         
         */
        
        if let id = self.arrayOfChats[indexPath.row]["toUserId"] as? Int {
            if "\(id)" == SingletonClass.sharedInstance.id {
                cell.lblreceiverMessage.isHidden = true
            }else{
                cell.lblsenderMessage.isHidden = true
            }
        }
        
        if let name = self.arrayOfChats[indexPath.row]["message"] as? String
        {
            cell.lblreceiverMessage.text = name
        }
        
//        if let createdDateTime = self.arrayOfChats[indexPath.row]["createdDateTime"] as? String
//        {
//            cell.lblDate.text = createdDateTime.replacingOccurrences(of: "T", with: "\n")
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let message = self.arrayOfChats[indexPath.row]["message"] as? Int, let fromUserId = self.arrayOfChats[indexPath.row]["fromUserId"] as? String, let toUserId = self.arrayOfChats[indexPath.row]["toUserId"] as? String else {
            
            print("Values of one of the data is not present")
            return
        }
        print("selected \(message) and from \(fromUserId) to \(toUserId)")
        
    }
}
