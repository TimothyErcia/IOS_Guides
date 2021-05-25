//
//  DataModel.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 4/26/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable{
   var id: Int = 0
   var userId: Int = 0
   var title: String = ""
   var body: String = ""
}

struct Album: Codable, Identifiable{
   var id: Int = 0
   var albumId: Int = 0
   var title: String = ""
   var url: String = ""
   var thumbnailUrl: String = ""
}

class APICollection {
   func getAllPost(completion: @escaping ([Post]) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard let postData = data else { return }
         do {
            let post = try JSONDecoder().decode([Post].self, from: postData)
           
            DispatchQueue.main.async {
               completion(post)
            }
         } catch {
            print("Has error \(error)")
         }
         
      }.resume()
   }
   
   func getPost(param: String, completion: @escaping (Post) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(param)") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard let postData = data else { return }
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
           
            DispatchQueue.main.async {
               completion(post)
            }
         } catch {
            print("Has error \(error)")
         }
         
      }.resume()
   }
   
   func createPost(param: Post, completion: @escaping (Post) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
      
      let body: [String: Any] = [
         "title": param.title,
         "body": param.body,
         "userId": param.userId,
         "id": param.id
      ]
      
      let bodyValue = try? JSONSerialization.data(withJSONObject: body)
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      request.httpBody = bodyValue
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard let postData = data else { return }
         
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            
            DispatchQueue.main.async {
               completion(post)
            }
            
         } catch {
            print("Has error \(error)")
         }
         
      }.resume()
   }
   
   func updatePost(param: Post, completion: @escaping (Post) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(param.id)") else { return }
      
      let body: [String: Any] = [
              "title": param.title,
              "body": param.body,
              "userId": param.userId,
              "id": param.id
           ]
      
      let bodyData = try? JSONSerialization.data(withJSONObject: body)
      
      var request = URLRequest(url: url)
      request.httpMethod = "PUT"
      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
      request.httpBody = bodyData
      
      URLSession.shared.dataTask(with: request){ data, response, error in
         guard let postData = data else { return }
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            DispatchQueue.main.async {
               completion(post)
            }
         } catch {
            print("Has error \(error)")
         }
      }.resume()
   }
   
   func deletePost(id: String, completion: @escaping (Post) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "DELETE"
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard let postData = data else { return }
         do {
            let post = try JSONDecoder().decode(Post.self, from: postData)
            
            DispatchQueue.main.async {
               completion(post)
            }
            
         } catch {
            print("\(error)")
         }
         
      }.resume()
      
   }
   
   func getAllAlbums(completion: @escaping ([Album]) -> ()){
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
         guard let albumData = data else { return }
         
         do {
            let album = try JSONDecoder().decode([Album].self, from: albumData)
            DispatchQueue.main.async {
               completion(album)
            }
            
         } catch {
            print(error)
         }
      }.resume()
   }
}
