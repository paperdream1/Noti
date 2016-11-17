/**
 This file is part of the Reductio package.
 (c) Sergio Fernández <fdz.sergio@gmail.com>
 
 For the full copyright and license information, please view the LICENSE
 file that was distributed with this source code.
 */

import Foundation

internal struct Stemmer {
    
    typealias Language = String
    typealias Script = String
    
    private static let language: Language = "en"
    private static let script: Script = "Kore"
    private static let orthography = NSOrthography(dominantScript: script, languageMap: [script : [language]])
    
    static func stemmingWordsInText(_ text: String) -> [String] {
        
        var stems: [String] = []
        
        
        let range = NSRange(location: 0, length: text.characters.count)
        let tagOptions: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
        let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        let tagger = NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(tagOptions.rawValue))
        
        tagger.string = text
        tagger.setOrthography(orthography, range: range)
        tagger.enumerateTags(in: range, scheme: NSLinguisticTagSchemeLemma, options: tagOptions) { (tag: String?, tokenRange, range, stop) in
            let token = (text as NSString).substring(with: tokenRange)
            print("token:" + token)
            if !token.isEmpty {
                stems.append(token.lowercased())
                
            }
        }
        
        return stems
        //print(stems)
        /*
         var jsonObj:[String:[String]]? = nil
         
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
         
         
         jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! [String:[String]]
         
         
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
         
         
         print(jsonObj!["result"]!)
         //stems = jsonObj["result"]!
         
         //return jsonObj!["result"]!
         return []*/
    }
}
