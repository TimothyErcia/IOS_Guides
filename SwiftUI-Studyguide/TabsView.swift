//
//  TabsView.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 5/17/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
      customTabView()
         .navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
}

private struct customTabView: View {
   @State var selectedIndex: Int = 0
   @State var toggleSheet1: Bool = false
   @State var toggleSheet2: Bool = false
   @State var sampleBool: Bool = false
   
   var body: some View {
      ZStack {
         if self.toggleSheet2 {
            VStack {
               Lesson6View(isPresented: $toggleSheet2, coreDM: CoreDataManager())
                  .animation(.default)
               .offset(x: 0, y: sampleBool ? 0 : 300)
            }.onAppear {
               self.sampleBool = true
            }
            .onDisappear {
               self.sampleBool = false
            }
         }
         else {
            VStack {
               ZStack {
                  if selectedIndex == 0 {
                     NavigationView {
                        VStack {
                           appBar(title: "Modal")
                           Spacer()
                           
                           Button(action: {
                              self.toggleSheet1.toggle()
                           }){
                              Text("Open Sheet")
                           }
                           
                           Spacer()
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                     }
                  }
                  else if selectedIndex == 1 {
                     NavigationView {
                        VStack(spacing: 25) {
                           appBar(title: "Modal")
                           Spacer()
                           
                           Button(action: {
                              self.toggleSheet2.toggle()
                           }){
                              Text("Open Custom Modal")
                           }
                           
                           Spacer()
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                     }.sheet(isPresented: $toggleSheet1) {
                        Lesson5View()
                     }
                  }
               }
               
               Spacer()
               
               HStack(spacing: 100) {
                  Button(action: {
                     self.selectedIndex = 0
                  }){
                     Text("Tab 1")
                  }
                  
                  Button(action: {
                     self.selectedIndex = 1
                  }){
                     Text("Tab 2")
                  }
               }
            }
         }
      }
   }
}

//private struct nativeTabView: View {
//   var body: some View {
//      TabView {
//         NavigationView {
//            VStack {
//               HStack {
//                  buttonView(text: "Lesson1")
//                  buttonView(text: "Lesson2")
//               }
//
//               HStack {
//                  buttonView(text: "Lesson3")
//                  buttonView(text: "Lesson4")
//               }
//            }.navigationBarTitle("Home", displayMode: .large)
//         }.tabItem {
//            Text("Home 1")
//         }
//
//         NavigationView {
//            VStack {
//               HStack {
//                  buttonView(text: "Lesson1")
//                  buttonView(text: "Lesson2")
//               }
//
//               HStack {
//                  buttonView(text: "Lesson3")
//                  buttonView(text: "Lesson4")
//               }
//            }.navigationBarTitle("Home", displayMode: .large)
//         }.tabItem {
//            Text("Home 1")
//         }
//      }
//   }
//}

private struct appBar: View {
   var title: String
   var body: some View {
      HStack {
         Text(title)
         .font(.largeTitle)
            .fontWeight(.heavy)
            .padding()
         Spacer()
      }
   }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
