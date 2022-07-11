//
//  Helper.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 10/07/2022.
//

import Foundation
import UIKit


class Helper {
    static let shared = Helper()
    
    // Convert Unix Time to readable date
    func FixUnixDate(UinxDate : Double) -> String {
        let Date : NSDate = NSDate(timeIntervalSince1970: UinxDate)
        let Formatter : DateFormatter = DateFormatter()
        Formatter.dateFormat = "YYYY/MM/dd - HH:MM a"
        Formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return Formatter.string(from: Date as Date)
    }
    
    // replace non allowed characters like # or space in string
    func FixStringToAllowedInRequest(NonAllowedString : String) -> String {
        return NonAllowedString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
    }
    
    func ShowDialog(Title : String, Message : String, Parent : UIViewController) {
        
        let ErrorDialogMessage = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let OkButton = UIAlertAction(title: "OK", style: .default)
        ErrorDialogMessage.addAction(OkButton)
        Parent.present(ErrorDialogMessage, animated: true)
    }
}
