//
//  ViewController.swift
//  Upload_data
//
//  Created by Dhaval Nimavat on 26/09/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submit(_ sender: Any) {
        insert_data()
    }
    
    func insert_data()
    {
       
        let myUrl = URL(string: "https://iosapps.epizy.com/insertdata.php")
        
        var myRequest = URLRequest(url: myUrl!)
        
        myRequest.httpMethod = "POST"
        
        let parameter:[String:Any] = ["name":name.text!,"surname":surname.text!,"city":city.text!]
        
        myRequest.httpBody = parameter.percentEncoded()
        
        
        DispatchQueue.main.async {
            
       
        let task = try! URLSession.shared.dataTask(with: myRequest)
        {
            (mydata,URLResponse,Error) in
              
        }
        task.resume()
        }
       
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


