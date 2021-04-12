//
//  AboutView.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 4/12/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct AboutView: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State var firstName: String = ""
   @State var lastName: String = ""
   @State var emailAddress: String = ""
   @State var mobileNumber: String = ""
   @State var password: String = ""
   @State var message: String = ""
   
    var body: some View {
      VStack{
         appBar(presentationMode: self.presentationMode)
         Form {
            Section(header: Text("This is a header value of section")){
               HStack{
                  Text("Detail 1")
                  Spacer()
                  Text("Detail Value")
               }
            }
            
            Section(footer: Text("This is a footer value of section")){
               HStack{
                  Text("Detail 2")
                  Spacer()
                  Text("Detail Value")
               }
            }
            
            Section{
               CustomTextEditor(placeholder:"Message",
                                message: self.$message)
                  .frame(height: 120)
            }
            
            Section(header: Text("Version Control")){
               HStack{
                  Text("Version")
                  
                  Spacer()
                  
                  Text("1.0.0")
               }
            }
         }
         .frame(height: 650)
         
         Spacer()
      }.background(Color(red: 242/255, green: 242/255, blue: 247/255))
    }
}

private struct CustomTextEditor: UIViewRepresentable {
   var placeholder: String
   @Binding var message: String
   
   func makeUIView(context: Context) -> UITextView {
      let textView = UITextView()
      
      textView.font = UIFont.systemFont(ofSize: 15)
      textView.textColor = .gray
      textView.isEditable = false
      textView.isSelectable = true
      textView.isUserInteractionEnabled = true
      textView.delegate = context.coordinator
      
      return textView
   }
   
   func updateUIView(_ uiView: UITextView, context: Context){
      uiView.text = self.placeholder
   }
   
   func makeCoordinator() -> Coordinator {
      Coordinator(self)
   }
   
   class Coordinator: NSObject, UITextViewDelegate{
      var parent: CustomTextEditor
      
      init(_ parent: CustomTextEditor){
         self.parent = parent
      }
      
      func textViewDidBeginEditing(_ textView: UITextView) {
         if textView.text == parent.placeholder {
            textView.text = ""
            textView.textColor = .black
         }
      }
      
      func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text == "" {
            textView.text = parent.placeholder
            textView.textColor = .gray
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
                  .foregroundColor(Color.white)
               
               Text("Lesson 1")
                  .navigationBarTitle("")
                  .navigationBarBackButtonHidden(true)
                  .navigationBarHidden(true)
                  .foregroundColor(Color.white)
            }
            
            Spacer()
         }
      }
      .padding()
      .background(Color.blue.edgesIgnoringSafeArea(.top).shadow(color: .black, radius: 3))
   }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
