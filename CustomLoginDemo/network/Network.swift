//
//  Network.swift
//  CustomLoginDemo
//
//  Created by Oladipupo Oluwatobi Hammed on 19/05/2020.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import Foundation




func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil, error)
            }
            return
        }
        let decoder = JSONDecoder()
        do {
            let responseObject = try decoder.decode(ResponseType.self, from: data)
            DispatchQueue.main.async {
                completion(responseObject, nil)
            }
        } catch {
            print(error.localizedDescription)
            completion(nil, error)
        }
    }
    task.resume()
    
    return task
}
 func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?, Int?) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try! JSONEncoder().encode(body)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let httpResponse = response as? HTTPURLResponse {
            DispatchQueue.main.async {
                completion(nil, nil, httpResponse.statusCode)
            }
            print("error \(httpResponse.statusCode)")
        }
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil, error, nil)
            }
            return
        }
        let decoder = JSONDecoder()
        do {
            let responseObject = try decoder.decode(ResponseType.self, from: data)
            DispatchQueue.main.async {
                completion(responseObject, nil, nil)
            }
        } catch {
            do {
                let errorResponse = try decoder.decode(NetErrorResponse.self, from: data) as Error
                DispatchQueue.main.async {
                    completion(nil, errorResponse, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error, nil)
                }
            }
        }
    }
    task.resume()
}


func login(email: String, password: String,role: String, completion: @escaping (Result<SignInResponse, Error>?,Int? ) -> Void) {
    guard let url = URL(string: "http://trudev-env.eba-8x69ujbd.us-east-1.elasticbeanstalk.com/api/auth/login") else { return }
    let body = LoginRequest(email: email, password: password, role: role)
    taskForPOSTRequest(url:url, responseType: SignInResponse.self, body: body) { response, error, status  in
        if let response = response {
            completion(.success(response), nil)
        } else if let err = error {
            completion(.failure(err), nil)
        } else if let status = status {
            completion(nil, status)
        }
    }
}

func signup(email: String, password: String,passwordConfirmation:String ,firstName: String,lastName: String, middleName: String,driverType:String,cityId:Int, phoneNumber: String, completion: @escaping (Result<SignInResponse, Error>?, Int? ) -> Void) {
    guard let url = URL(string: "http://trudev-env.eba-8x69ujbd.us-east-1.elasticbeanstalk.com/api/auth/driver/register") else { return }
    let body = SIgnUpRequest(email: email, password: password, passwordConfirmation: passwordConfirmation, firstName: firstName, lastName: lastName, middleName: middleName, driverType: driverType, cityId: cityId, phoneNumber: phoneNumber)
    taskForPOSTRequest(url:url, responseType: SignInResponse.self, body: body) { response, error,status  in
        if let response = response {
            completion(.success(response), nil)
        } else if let err = error {
            completion(.failure(err), nil)
        } else if let status = status {
            completion(nil, status)
        }
    }
}
func getPost(completion: @escaping (Result<[Post], Error> ) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
   _ = taskForGETRequest(url:url, responseType: [Post].self) { response, error in
        if let response = response {
            completion(.success(response))
        } else if let err = error {
            completion(.failure(err))
        }
    }
}
