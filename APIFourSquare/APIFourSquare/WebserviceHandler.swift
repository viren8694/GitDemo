//
//  WebserviceHandler.swift
//  APIFourSquare
//
//  Created by Viren Patel on 3/19/18.
//  Copyright © 2018 Viren Patel. All rights reserved.
//

import Foundation

typealias completionHandler = (response?, Error?) -> ()

class WebServiceHandler: NSObject
{
    private override init() {}
    static let sharedInstance = WebServiceHandler()
    func getVenues(cityname: String, searchStr: String ,completion: @escaping completionHandler)
    {
        let urlStr = String(format: FOURSQUARE_URL,cityname,searchStr,Client_ID,Client_Secret)
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil
            {
                let decoder = JSONDecoder()
                do{
                    let jsonData = try decoder.decode(jsondata.self, from: data!)
                    completion(jsonData.response,nil)
                }
                catch
                {
                    completion(nil,error)
                }
            }
            else
            {
                completion(nil,error)
            }
        }.resume()
    }
}
