//
//  ServerManager.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/14/21.
//

import UIKit

struct ServerManager {
    
    // MARK: - Server Constants
    static let serverURL = "https://dragon-odyssey-server.conveyor.cloud/"
    
    // MARK: - USERS Constants
    static let getAllUsers = "/api/Users/GetAll"
    static let getUserByID = "/api/Users/GetById"
    static let getUserByFBuid = "/api/Users/GetByFirebaseUID"
    static let getUserByUsername = "/api/Users/GetByUsername"
    static let getUserByEmail = "/api/Users/GetByEmail"
    static let postAddUser = "/api/Users/Add"
    
    // MARK: - CREATURES Constants
    static let getAllCreatures = "/api/Creatures/GetAll"
    static let getCreatureByID = "/api/Creatures/GetById"
    static let getCreatureByUserID = "/api/Creatures/GetByUserId"
    static let getCreatureByName = "/api/Creatures/GetByName"
    static let postAddCreature = "/api/Creatures/Add"
    
    // MARK: - ITEM Constants
    static let getAllItems = "/api/Items/GetAll"
    static let getItemByID = "/api/Items/GetById"
    static let getItemByUserID = "/api/Items/GetByUserId"
    static let getItemByName = "/api/Items/GetByName"
    static let postAddItem = "/api/Items/Add"
    
    
    
    static func createUser(email: String, firebaseUID: String, username: String) {
        //Example:
        //https://dragon-odyssey.conveyor.cloud/api/Users/Add?email=dragonO@gmail.com&firebaseUID=asdfasdfasd&username=testUser
        
        let urlString = serverURL + postAddUser +
                        "?email=" + email +
                        "&firebaseUID=" + firebaseUID +
                        "&username=" + username
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            parseUserJSON(data: data)

        }
        
        task.resume()
    }
    
    static func parseUserJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(user.self, from: data)
            print("decodedData: \(decodedData)")
        } catch {
            //self.delegate?.didFailWithError(error: error)
            print("Parse JSON Error: \(error)")
            return //nil
        }
    }
}

struct user: Decodable {
    var id: String
    var firebaseUID: String
    var username: String
    var email: String
}

/*
 class ViewController: UIViewController {
     
     var url = "https://dragon-odyssey.conveyor.cloud/api/Tests/GetJson"

     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
         //performRequest(with: url)
         createCreature()
     }
     
     private func createUser(email: String, firebaseUID: String, username: String) {
         //Example:
         //https://dragon-odyssey.conveyor.cloud/api/Users/Add?email=dragonO@gmail.com&firebaseUID=asdfasdfasd&username=testUser
         let addUserURL = "https://dragon-odyssey.conveyor.cloud/api/Users/Add?"
         
         let urlString = addUserURL + "email=" + email + "&firebaseUID" + firebaseUID + "&username=" + username
         
         let url = URL(string: urlString)
         
         let request = URLRequest(url: url!)
         
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             
             guard let data = data, error == nil else {
                 print(error?.localizedDescription ?? "No data")
                 return
             }
             
             let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
             if let responseJSON = responseJSON as? [String: Any] {
                 print(responseJSON)
             }

         }
         
         task.resume()
     }
     
     private func createCreature() {
         let myCreature = creature()
         let json: [String : Any] = ["name" : myCreature.name,
                                     "energy" : myCreature.energy,
                                     "maxEnergy" : myCreature.maxEnergy,
                                     "agility" : myCreature.agility,
                                     "strength" : myCreature.strength,
                                     "latitude" : myCreature.latitude,
                                     "longitude" : myCreature.longitude]
         
         let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
         var stringData = String(data: doubleToSingleQuote(data: jsonData!), encoding: .utf8)!
         stringData = "\"" + stringData + "\""
         print("Data = \(stringData)")
         let safeData = Data(stringData.utf8)
         
         let theURL = "https://dragon-odyssey.conveyor.cloud/api/Users/Add?"// + stringData
         
         //create post
         let url = URL(string: theURL)
         //print("URL = \(url)")
         var request = URLRequest(url: url!)
         
         request.httpMethod = "POST"
         request.httpBody = safeData
         request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
         request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
         
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             
             guard let data = data, error == nil else {
                 print(error?.localizedDescription ?? "No data")
                 return
             }
             
             let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
             if let responseJSON = responseJSON as? [String: Any] {
                 print(responseJSON)
             }

         }
         
         task.resume()
     }

     
     private func performRequest(with urlString: String) {
         if let url = Foundation.URL(string: urlString) { //create URL
             let session = URLSession(configuration: .default) //Create URL Session
             let task = session.dataTask(with: url, completionHandler: { (data, response, error) in //Give the session a task
                 
                 //if there's an error, print the error and exit the function
                 if let theError = error {
                     print(theError)
                     return
                 }
                 
                 if let safeData = data {
                     self.parseJSON(safeData)
                 }
             })
             task.resume() //Start the task
         }
     }
     
     private func parseJSON(_ safeData: Data) {
         let decoder = JSONDecoder()
         do {
             let decodedData = try decoder.decode(creature.self, from: singleToDoubleQuote(data: safeData))
             print("Creature = \(decodedData)")
         } catch {
             print("Parse JSON Error: \(error)")
             return //nil
         }
         
     }
 }

 private func singleToDoubleQuote(data: Data) -> Data {
     var stringData = String(data: data, encoding: .utf8)!
     stringData = stringData.replacingOccurrences(of: "\'", with: "\"")
     return Data(stringData.utf8)
 }

 private func doubleToSingleQuote(data: Data) -> Data {
     var stringData = String(data: data, encoding: .utf8)!
     stringData = stringData.replacingOccurrences(of: "\"", with: "\'")
     return Data(stringData.utf8)
 }

 struct creature: Codable {
     var name: String = "Generic Name"
     var energy: Int = 5
     var maxEnergy: Int = 100
     var agility: Int = 50
     var strength: Int = 50
     var longitude: Double = 100.001
     var latitude: Double = 100.002
 }

 */
