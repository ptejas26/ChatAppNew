//
//  UserListViewController.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/10/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet var userTableView: UITableView!

    /// Array to hold the list of users
    var arrayOfUsers : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        webserviceToFetchListOfUsers()
        self.title = "Welcome, " + SingletonClass.sharedInstance.name
    }
    
    func webserviceToFetchListOfUsers()
    {
        Webservice.sharedInstance.getMethodRequest(Helper.URLs.BaseURL+Helper.URLs.userList, view: self.view) { (response) in
            guard response.result.error == nil else {
                print("error calling api")
                print(response.result.error!)
                return
            }
            
            //print(response.result.value as? [AnyObject])

            guard let json = response.result.value as? [AnyObject] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            
            self.arrayOfUsers = json
            self.userTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: ---- TABLE VIEW DATASOURCE AND DELEGATE -----
extension UserListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserChatTableViewCell
        
        if let name = self.arrayOfUsers[indexPath.row]["name"] as? String
        {
            cell.lblName.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected users \(self.arrayOfUsers[indexPath.row]["id"])")
        pushController(indexPath)
    }
    func pushController(_ indexPath : IndexPath)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let chatVC : ChatViewController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        //Here there is scope of creating model class and accessing properties using dot operator, but due to time constraint doing it directly.
        
        guard let userid = self.arrayOfUsers[indexPath.row]["id"] as? Int, let username = self.arrayOfUsers[indexPath.row]["name"] as? String else {
            
            print("Values of one of the data is not present")
            return
        }
        
        chatVC.userName = username
        chatVC.userID = "\(userid)"
        
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}
