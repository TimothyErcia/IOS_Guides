//
//  Lesson3View.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 3/25/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson2View: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State var showAnimation1: Bool = false
   @State var showAnimation2: Bool = false
   @State var showAnimation3: Bool = false
   @State var showAnimation4: Bool = false
   
   var body: some View {
      VStack (alignment: .leading){
         appBar(presentationMode: self.presentationMode)
         
         ScrollView(.vertical) {
            VStack(alignment: .leading){
               Text("Animations")
                  .font(.title)
                  .padding(12)
               
               ButtonView(
                  showAnimation1: $showAnimation1,
                  animationType: "slide")
               
               ButtonView(
                  showAnimation1: $showAnimation2,
                  animationType: "move")
               
               ButtonView(
                  showAnimation1: $showAnimation3,
                  animationType: "expand")
               
               ButtonView(
                  showAnimation1: $showAnimation4,
                  animationType: "offset")
               
               Spacer()
               
               GeometryReader{ geo in
                  NavigationLink(destination: Lesson3View(), label: {
                     Text("Go to Lesson 3")
                        .frame(width: geo.size.width, alignment: .center)
                        .padding(.top, 20)
                  })
               }.frame(height: 55)
            }
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
               
               Text("Lesson 2")
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

private struct ButtonView: View {
   @Binding var showAnimation1: Bool
   var animationType: String
   
   var body: some View {
      HStack{
         Spacer()
         VStack {
            HStack {
               Spacer()
               
               Button(action: {
                  self.showAnimation1.toggle()
               }){
                  Text(animationType)
                     .frame(width: 250, height: 55)
                     .foregroundColor(Color.white)
                     .background(Color.blue)
                     .cornerRadius(8)
               }.padding(.bottom)
               
               Spacer()
            }
            
            HStack (alignment: .center){
               if self.animationType == "expand" {
                  Text(self.animationType)
                  .padding()
                  .frame(width: 100)
                  .border(Color.black)
                  .scaleEffect(x: showAnimation1 ? 3.5 : 1, y: 1, anchor: .center)
                  .animation(.easeInOut)
               }
                  
               else if self.showAnimation1 {
                  Text(self.animationType)
                  .padding()
                  .border(Color.black)
                  .background(Color.white)
                  .transition(containedView())
                  .animation(.easeInOut)
               }
            }
            
         }.padding()
         Spacer()
      }
   }
   
   func containedView() -> AnyTransition {
      switch self.animationType {
      case "slide": return .slide
      case "move": return .asymmetric(insertion: .move(edge: .top),
                                      removal: .move(edge: .bottom))
         
      case "offset": return .asymmetric(insertion: .offset(x: 0, y: 0),
                                        removal: .offset(x: 30, y: 30))
      default:
         return .slide
      }
   }
}

struct conditionalView: View {
   var body: some View {
      HStack{
         Spacer()
         
         Text("Slide InOut Animation")
            .padding()
         
         Spacer()
      }
      .transition(AnyTransition.slide)
      .animation(.default)
   }
}


struct Lesson2View_Previews: PreviewProvider {
   static var previews: some View {
      Lesson2View()
   }
}
