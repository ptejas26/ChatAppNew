//
//  Webservice.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/10/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit
import Alamofire

class Webservice: NSObject {
    
    static let sharedInstance = Webservice()
    
    func postMethodRequest(_ url : String, param : [String:AnyObject], view: UIView,completionHandler: @escaping (DataResponse<Any>) -> ())
    {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : SingletonClass.sharedInstance.token
            ]
        
        /*
         
         SUCCESS: {
         id = 2070;
         name = test;
         token = "724c63a4-13d2-4918-8226-4c9dce53cabe";
         }
         (lldb)
         */
        
        SingletonClass.sharedInstance.showActivityIndicator(uiView: view)
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response)
        
            SingletonClass.sharedInstance.removeActivityIndicator(view)
            
            //let myStruct = try JSONDecoder().decode(Models.Login.self, from: myJsonData!)
            //print(myStruct)
            
            if let json = response.result.value as? [String: Any]
            {
                completionHandler(response)
            }
            else
            {
                completionHandler(response)
            }
        }
    }
    
    func getMethodRequest(_ url : String, view: UIView,completionHandler: @escaping (DataResponse<Any>) -> ())
    {
        let headers: HTTPHeaders = [
            "Authorization" : SingletonClass.sharedInstance.token,
            "Content-Type": "application/json"
        ]
        SingletonClass.sharedInstance.showActivityIndicator(uiView: view)

        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response)
            SingletonClass.sharedInstance.removeActivityIndicator(view)

            
            //let myStruct = try JSONDecoder().decode(Models.Login.self, from: myJsonData!)
            //print(myStruct)
            
            if let json = response.result.value as? [AnyObject]
            {
                completionHandler(response)
            }
            else
            {
                completionHandler(response)
            }
      }
}



/*
 struct Swifter: Decodable {
 let fullName: String
 let id: Int
 let twitter: URL
 }
 
 let json = """
 {
 "fullName": "Federico Zanetello",
 "id": 123456,
 "twitter": "http://twitter.com/zntfdr"
 }
 """.data(using: .utf8)! // our data in native (JSON) format
 let myStruct = try JSONDecoder().decode(Swifter.self, from: json) // Decoding our data
 print(myStruct) // decoded!!!!!
 
 
 */
}


/*
 
 
 func getOrders(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
 makeCall("orders", completionHandler: completionHandler)
 }
 
 func makeCall(_ section: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
 let params = ["consumer_key":"key", "consumer_secret":"secret"]
 
 Alamofire.request("\(apiUrl)/\(apiEndPoint + section)", parameters: params)
 .authenticate(user: consumerKey, password: consumerSecret)
 .responseJSON { response in
 switch response.result {
 case .success(let value):
 completionHandler(value as? NSDictionary, nil)
 case .failure(let error):
 completionHandler(nil, error)
 }
 }
 }

 */


/*
 
 do
 {
 //data(using: .utf8)!
 let myJsonData = response.data?.base64EncodedData()
 }
 catch{
 print("Could not cast the json to decodable object")
 }
 */
