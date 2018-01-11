//
//  SingletonClass.swift
//  
//
//  Created by Nilesh's MAC on 1/11/18.
//

import UIKit

class SingletonClass: NSObject {

    //Shared instance variable
    static let sharedInstance = SingletonClass()
    
    //Activity indicator
    var activityIndicator : UIActivityIndicatorView?
    
    //Device token
    var token : String = ""
    var id : String = ""
    var name : String = ""
    
    func showActivityIndicator(uiView: UIView) {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator?.center = uiView.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        uiView.addSubview(activityIndicator!)
        uiView.isUserInteractionEnabled = false
        activityIndicator?.startAnimating()
    }
    
    func removeActivityIndicator(_ uiView: UIView)
    {
        if activityIndicator != nil{
            
            uiView.isUserInteractionEnabled = true
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()            
        }
    }
    
    func showAlertView(title: String, message:String,viewC:UIViewController)
    {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(okAction)
        
        viewC.present(alertViewController, animated: true, completion: nil)
    }
    
}

