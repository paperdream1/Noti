//
//  KeyPhrase.swift
//  Pods
//
//  Created by 이채원 on 2016. 11. 22..
//
//

import Foundation

class KeyPhrase {
    class func pickKeyPhrase(word : String) -> String
    {
        var result : String = ""
        
        for w in KorStemmer.phrases
        {
            //print("b" + w)
            
            if(w.contains(word) && result.components(separatedBy: " ").count < w.components(separatedBy: " ").count)
            {
                result = w
            }
        }
        
        return result
    }
}
