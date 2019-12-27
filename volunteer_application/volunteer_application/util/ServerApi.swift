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
    
    static func getAllTasks(userId: Int64, dGroup: DispatchGroup,  completion: @escaping ([Task]) -> Void) {
        let request = createRequest(endPointUrl: "/v1/task/\(userId)/tasks", httpMethod: "GET", httpBody: nil)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                dGroup.leave()
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }
            
            guard let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
                dGroup.leave()
                return
            }
                
            completion(tasks)
            dGroup.leave()
        }
        task.resume()
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
            dGroup.leave()
            return
        }
        let request = createRequest(endPointUrl: "/v1/user/auth", httpMethod: "POST", httpBody: jsonBody)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                dGroup.leave()
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
            dGroup.leave()
            return
        }
        let request = createRequest(endPointUrl: "/v1/user/register", httpMethod: "PUT", httpBody: jsonBody)
        let task = createSession().dataTask(with: request) { (_, _, _) in
            dGroup.leave()
        }
        
        task.resume()
    }
    
    static func updateStatus(taskId: Int64, status: String, dGroup: DispatchGroup) {
        let request = createRequest(endPointUrl: "/v1/task/\(taskId)/?status=\(status)", httpMethod: "PUT", httpBody: nil)
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil else {
                dGroup.leave()
                return
            }
            dGroup.leave()
        }
        task.resume()
    }
    
    static func createNewTask(task: Task, userId: Int64, dGroup: DispatchGroup, completion: @escaping (Task) -> Void) {
        guard let jsonBody = try? JSONEncoder().encode(task) else {
            dGroup.leave()
            return
        }
        
        let request = createRequest(endPointUrl: "/v1/task/\(userId)/createTask", httpMethod: "POST", httpBody: jsonBody)
        
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                dGroup.leave()
                return
            }
            
            guard let taskFromSever = try? JSONDecoder().decode(Task.self, from: data) else {
                dGroup.leave()
                return
            }
            
            completion(taskFromSever)
            dGroup.leave()
            
        }
        
        task.resume()
    }
    
    static func register(person: Person, dGroup: DispatchGroup, completion: @escaping (Person) -> Void) {
        guard let jsonBody = try? JSONEncoder().encode(person) else {
            dGroup.leave()
            dGroup.leave()
            return
        }
        
        let request = createRequest(endPointUrl: "/v1/user/", httpMethod: "POST", httpBody: jsonBody)
        
        let task = createSession().dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                dGroup.leave()
                dGroup.leave()
                return
            }
            
            guard let personFromServer = try? JSONDecoder().decode(Person.self, from: data) else {
                dGroup.leave()
                dGroup.leave()
                return
            }
            
            completion(personFromServer)
            dGroup.leave()
            
        }
        
        task.resume()
    }
}
