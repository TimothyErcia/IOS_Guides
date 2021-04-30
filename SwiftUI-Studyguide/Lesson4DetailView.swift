//
//  Lesson4DetailView.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 4/28/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson4DetailView: View {
   @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State var postDetail: Post = Post()
   var id: String
   
   var body: some View {
      VStack{
         appBar(presentationMode: presentationMode)
         
         VStack (alignment: .leading) {
            Text("User ID")
               .fontWeight(.bold)
            
            Text("\(postDetail.userId)")
               .frame(height: 25)
            
            Text("Title")
               .fontWeight(.bold)
            TextField("Title", text: $postDetail.title)
               .frame(height: 20)
               .border(Color.black)
               .disabled(true)
               
            
            Text("Body")
               .fontWeight(.bold)
            Text("\(postDetail.body)")
               .frame(height: 25)
            
            Button(action: {
               APICollection().deletePost(id: "\(self.postDetail.id)"){ (res) in
                  print("Resource deleted  \(res)")
               }
            }){
               Text("Delete Data")
            }
            
         }.padding()
         
         Spacer()
      }.onAppear {
         APICollection().getPost(param: self.id) { (res) in
            self.postDetail = res
         }
      }
   }
}

private struct appBar: View {
   @Binding var presentationMode: PresentationMode
   var body: some View {
      VStack {
         HStack {
            Button(action: {
               self.$presentationMode.wrappedValue.dismiss()
            }){
               Image(systemName: "chevron.left")
                  .foregroundColor(Color.black)
            }
            
            Spacer()
            
            Text("Detail")
               .font(.system(size: 25))
               .navigationBarTitle("")
               .navigationBarBackButtonHidden(true)
               .navigationBarHidden(true)
               .foregroundColor(Color.black)
            
            Spacer()
         }
      }
      .padding()
      .background(Color.white.edgesIgnoringSafeArea(.top))
   }
}

private struct KeyboardManagement: ViewModifier {
    @State private var offset: CGFloat = 0
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                           self.offset = keyboardFrame.height - geo.safeAreaInsets.bottom
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                        withAnimation(Animation.easeOut(duration: 0.1)) {
                           self.offset = 0
                        }
                    }
                }
            .padding(.bottom, self.offset)
        }
    }
}
