//
//  Lesson4View.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 4/26/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson4View: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State var posts: [Post] = [Post]()
   @State var samplePost: Post = Post(id: 1, userId: 1, title: "sample title", body: "sample body")
   
   var body: some View {
      VStack {
         appBar(presentationMode: presentationMode, sampleData: $samplePost, collection: $posts)
         DataView(posts: $posts)
         Spacer()
      }.onAppear {
         APICollection().getAllPost { (res) in
            self.posts = res
         }
      }
   }
}

private struct appBar: View {
   @Binding var presentationMode: PresentationMode
   @Binding var sampleData: Post
   @Binding var collection: [Post]
   
   var body: some View {
      VStack {
         HStack {
            Button(action: {
               self.$presentationMode.wrappedValue.dismiss()
            }){
               Image(systemName: "chevron.left")
                  .foregroundColor(Color.white)
               
               Text("Lesson 4")
                  .navigationBarTitle("")
                  .navigationBarBackButtonHidden(true)
                  .navigationBarHidden(true)
                  .foregroundColor(Color.white)
            }
            
            Spacer()
            
            Button(action: {
               self.collection = []
               APICollection().createPost(param: self.sampleData) { (res) in
                  print("added data \(res)")
                  APICollection().getAllPost { (res) in
                     self.collection = res
                  }
               }
            }){
               Image(systemName: "plus.circle")
                  .foregroundColor(Color.white)
            }
         }
      }
      .padding()
      .background(Color.blue.edgesIgnoringSafeArea(.top).shadow(color: .black, radius: 3))
   }
}

private struct DataView: View {
   @Binding var posts: [Post]
   
   var body: some View {
      VStack {
         List {
            ForEach(posts) { item in
               NavigationLink(destination: Lesson4DetailView(id: "\(item.id)")){
                  Text(item.title)
               }
            }
         }
      }
   }
}

struct Lesson4View_Previews: PreviewProvider {
   static var previews: some View {
      Lesson4View()
   }
}
