//
//  KorStemmer.swift
//  Pods
//
//  Created by 이채원 on 2016. 11. 17..
//
//

import Foundation

class KorStemmer {
    
    static var phrases : [String] = []
    
    class func stemmer(text:String) -> [String]
    {
        var stem:[String] = []
        var jsonObj:[String:AnyObject]? = nil
        
        var request = URLRequest(url: URL(string: "http://52.78.234.14/hyungtaeso")!)
        request.httpMethod = "POST"
        let postString = "sentence="+text
        request.httpBody = postString.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do{
                
                
                jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                
                
                //print(jsonObj)
                
                
            }catch let error as NSError {
                print(error)
                
            }
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(responseString)")
            //return jsonObj["result"]!
        }
        task.resume()
        
        while(jsonObj == nil){}
        
        /*
         for phrase in jsonObj?["phrases"] as! [String]
         {
         stem.append(contentsOf: phrase.components(separatedBy: " "))
         }*/
        
        var result : [String] = []
        for w in jsonObj!["stems_with_type"]! as! [[String]]
        {
            if(w[2] == "Noun")
            {
                result.append(w[1])
            }
        }
        
        KorStemmer.phrases.append(contentsOf: jsonObj?["phrases"] as! [String])
        
        //print(result)
        //return stem
        return result
    }
}
