//
//  Phone.swift
//  HereNow-iOS
//
//  Created by Shiv Vashisht on 2016-01-24.
//  Copyright (c) 2016 Ali Haghani. All rights reserved.
//

import Foundation

func tappedSendButton() {
    
    print("Tapped button")
    
    // Use your own details here
    let twilioSID = "APd0c85373c356c23371bc52fef0b7a02f"
    let twilioSecret = "bf2...b0b7"
    let fromNumber = "16043664044"
    let toNumber = "16043664043"
    let message = "Hello from the other side"
    
    // Build the request
    let request = NSMutableURLRequest(URL: NSURL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
    request.HTTPMethod = "POST"
    request.HTTPBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".dataUsingEncoding(NSUTF8StringEncoding)
    
    // Build the completion block and send the request
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
        print("Finished")
        if let data = data, responseDetails = NSString(data: data, encoding: NSUTF8StringEncoding) {
            // Success
            print("Response: \(responseDetails)")
        } else {
            // Failure
            print("Error: \(error)")
        }
    }).resume()
}


