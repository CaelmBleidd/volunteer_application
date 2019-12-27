//
//  ServerApi.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 24.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class ServerApi {
    
    private static let url = "https://itmo-volunteer-application.herokuapp.com/api"
  
    static func createRequest(endPointUrl: String, httpMethod: String, httpBody: Data?) -> URLRequest {
        guard let url = URL(string: self.url + endPointUrl) else {
            fatalError("Can't create non nil url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        return request
    }
    
    static func createSession() -> URLSession {
        let sessionConfiguration: URLSessionConfiguration

        sessionConfiguration = URLSessionConfiguration.default

        let session = URLSession(configuration: sessionConfiguration)

        return session
        
    }
    
    static func subscribe(eventId: Int64, userId: Int64, dGroup: DispatchGroup) {
        let request = createRequest(endPointUrl: "/v1/event/subscribe?eventId=\(eventId)&userId=\(userId)", httpMethod: "POST", httpBody: nil)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil else {
                dGroup.leave()
                return
            }
                       
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }

            dGroup.leave()
        }
        task.resume()
    }
    
    static func unsubscribe(eventId: Int64, userId: Int64, dGroup: DispatchGroup) {
        let request = createRequest(endPointUrl: "/v1/event/unsubscribe?eventId=\(eventId)&userId=\(userId)", httpMethod: "DELETE", httpBody: nil)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil else {
                dGroup.leave()
                return
            }
                       
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }

            dGroup.leave()
        }
        task.resume()
    }
    
    static func getEvents(dGroup: DispatchGroup, completion: @escaping ([Event]) -> Void) {
        let request = createRequest(
            endPointUrl: "/v1/event/\(UserDefaults.standard.integer(forKey: "currentUserId"))/events",
            httpMethod: "GET", httpBody: nil)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                dGroup.leave()
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }
            
            guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
                dGroup.leave()
                return
            }
                
            completion(events)
            dGroup.leave()
        }
        task.resume()
    }
    
    static func auth(userCredentials: UserCredentials, dGroup: DispatchGroup, completion: @escaping (Person) -> Void) {
        guard let jsonBody = try? JSONEncoder().encode(userCredentials) else {
            //error
            return
        }
        let request = createRequest(endPointUrl: "/v1/user/auth", httpMethod: "POST", httpBody: jsonBody)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                //error
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }
            
            guard let personFromServer = try? JSONDecoder().decode(Person.self, from: data) else {
                dGroup.leave()
                return
            }
                
            completion(personFromServer)
            dGroup.leave()

        }
        
        task.resume()
    }
    
    static func addPassword(userCredentials: UserCredentials, dGroup: DispatchGroup) {
        guard let jsonBody = try? JSONEncoder().encode(userCredentials) else {
            //error
            return
        }
        let request = createRequest(endPointUrl: "/v1/user/register", httpMethod: "PUT", httpBody: jsonBody)
        let task = createSession().dataTask(with: request) { (_, _, _) in
            dGroup.leave()
        }
        
        task.resume()
    }
    
    static func register(person: Person, dGroup: DispatchGroup, completion: @escaping (Person) -> Void) {
        guard let jsonBody = try? JSONEncoder().encode(person) else {
            //error
            return
        }
        
        let request = createRequest(endPointUrl: "/v1/user/", httpMethod: "POST", httpBody: jsonBody)
        
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                //error
                return
            }
            
            guard let personFromServer = try? JSONDecoder().decode(Person.self, from: data) else {
                dGroup.leave()
                return
            }
            
            completion(personFromServer)
            dGroup.leave()
            
        }
        
        task.resume()
    }
    
    
//    init() {
//        let sessionConfiguration = URLSessionConfiguration.default
//        session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
//    }
//
//    func login(_ login: String, _ password: String) -> Person? {
//        let requestUrl = URL(string: "https://itmo-volunteer-application.herokuapp.com/api/v1/user/auth")
//        var request = URLRequest(url: requestUrl!)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        let data = "login=\(login)&password=\(password)".data(using: String.Encoding.utf8)
//        request.httpBody = data
//
//        let task = self.session.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("error: \(error)")
//            } else {
//                if let response = response as? HTTPURLResponse {
//                    print("statusCode: \(response.statusCode)")
//                }
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print ("data: \(dataString)")
//                }
//            }
//        }
//        task.resume()
//        return nil
//    }
//
//    func register(_ person: Person, _ password: String, completion: @escaping (Person) -> Void) {
//        var currentUser: Person?
//        let url = URL(string: "https://itmo-volunteer-application.herokuapp.com/api/v1/user")!
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let parameters: [String: Any?] = [
//            "email": person.email,
//            "id": 0,
//            "login": person.login,
//            "name": person.firstName,
//            "patronymic": person.patronymic,
//            "phone": person.phoneNumber,
//            "photoLink": person.photoLink,
//            "rating": 1500,
//            "surname": person.lastName,
//            "verified": false,
//            "group": person.group
//        ]
//        request.httpBody = parameters.percentEncoded()
//
//        let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in guard let data = data else
//            { return }
//            do {
//                let user = try JSONDecoder().decode(Person.self, from: data)
//                completion(user)
//            } catch let error { /* errors */ }
//
//        })
//        task.resume()
//    }

    
//    let url = URL(string: "https://httpbin.org/get")!
//    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if let error = error {
//            print("error: \(error)")
//        } else {
//            if let response = response as? HTTPURLResponse {
//                print("statusCode: \(response.statusCode)")
//            }
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("data: \(dataString)")
//            }
//        }
//    }
//    task.resume()
}
