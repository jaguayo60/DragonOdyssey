//
//  ServerManager.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/14/21.
//

import UIKit

@available(iOS 13.0, *)
enum ImageType: String {
    case icons = "/api/Images/GetIcons"
    case buttons = "/api/Images/GetButtons"
    case items = "/api/Images/GetItems"
}

@available(iOS 13.0, *)
struct ServerManager {
    
    // MARK: - Server Constants
    private static let serverURL = "https://dragon-odyssey-server.conveyor.cloud"
    
    // MARK: - USERS Constants
    private static let getAllUsers = "/api/Users/GetAll"
    private static let getUserByID = "/api/Users/GetById"
    private static let getUserByFBuid = "/api/Users/GetByFirebaseUID"
    private static let getUserByUsername = "/api/Users/GetByUsername"
    private static let getUserByEmail = "/api/Users/GetByEmail"
    private static let postAddUser = "/api/Users/Add"
    
    // MARK: - CREATURES Constants
    private static let getAllCreatures = "/api/Creatures/GetAll"
    private static let getCreatureByID = "/api/Creatures/GetById"
    private static let getCreatureByUserID = "/api/Creatures/GetByUserId"
    private static let getCreatureByName = "/api/Creatures/GetByName"
    private static let postAddCreature = "/api/Creatures/Add"
    
    // MARK: - ITEM Constants
    private static let getAllItems = "/api/Items/GetAll"
    private static let getItemByID = "/api/Items/GetById"
    private static let getItemByUserID = "/api/Items/GetByUserId"
    private static let getItemByName = "/api/Items/GetByName"
    private static let postAddItem = "/api/Items/Add"
    
    // MARK: - IMAGE Constants
    private static let getImageList = "/api/Images/GetList"
    private static let getButtonImageList = "/api/Images/GetButtons"
    private static let getIconImageList = "/api/Images/GetIcons"
    private static let getItemImageList = "/api/Images/GetItems"
    //https://dragon-odyssey-server.conveyor.cloud//api/Images/GetItems
    
    @available(iOS 13.0, *)
    static func loadAllImages() {
        getImagesFor(type: .buttons)
        getImagesFor(type: .icons)
        getImagesFor(type: .items)
    }
    
    static func loadItemInfo() {
        let urlString = serverURL + getAllItems
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            parseItemJSON(data: data)

        }
        
        task.resume()
    }
    
    static func getImagesFor(type: ImageType) {
        let urlString = serverURL + type.rawValue
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            parseImageJSON(data: data, type: type)

        }
        
        task.resume()
    }
    
    static func loginUser(firebaseUID: String) {
        let urlString = serverURL + getUserByFBuid + "?firebaseUID=" + firebaseUID
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            parseUserJSON(data: data)
        }
        
        task.resume()
    }
    
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
            let decodedData = try decoder.decode(getUser.self, from: data)
            User.shared.firebaseUID = decodedData.firebaseUID
            User.shared.email = decodedData.email
            User.shared.username = decodedData.username
            User.shared.steps = decodedData.steps
            User.shared.tokens = decodedData.tokens
            //TODO: inventory items and creatures
        } catch {
            //self.delegate?.didFailWithError(error: error)
            print("Parse JSON Error: \(error)")
            return //nil
        }
    }
    
    static func parseItemJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([getItems].self, from: data)
            
            for item in decodedData {
                let newItem = Item(name: item.name,
                                   isAdOnly: item.isAdOnly,
                                   energyAmount: item.energyAmount,
                                   tokenCost: item.tokenCost)
                K.Items.list.append(newItem)
            }
        } catch {
            //self.delegate?.didFailWithError(error: error)
            print("Parse JSON Error: \(error)")
            return //nil
        }
    }
    
    @available(iOS 13.0, *)
    static func parseImageJSON(data: Data, type: ImageType) {
        let decoder = JSONDecoder()
        do {
            let decodedImageDataList = try decoder.decode([getImages].self, from: data)
            for anImage in decodedImageDataList {
                let urlString = serverURL + anImage.url
                let imageUrl = URL(string: urlString)!
                let imageData = try! Data(contentsOf: imageUrl)
                if let image = UIImage(data: imageData) {
                    switch type {
                    case .buttons:
                        K.Images.buttons.append((name: anImage.name, image: image))
                    case .icons:
                        K.Images.icons.append((name: anImage.name, image: image))
                    case .items:
                        K.Images.items.append((name: anImage.name, image: image))
                    }
                }
            }
        } catch {
            //self.delegate?.didFailWithError(error: error)
            print("Parse JSON Error: \(error)")
            return //nil
        }
    }
}

struct getImages: Decodable {
    var name: String
    var url: String
}

struct getUser: Decodable {
    var firebaseUID: String
    var username: String
    var email: String
    var steps: Int
    var tokens: Int
}

struct getItems: Decodable {
    var name: String
    var isAdOnly: Bool
    var energyAmount: Int
    var tokenCost: Int
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
