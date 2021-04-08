//
//  ContentView.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 2/17/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson1View: View {
   @State private var tip: String = ""
   @State private var bill: String = ""
   @State private var total: String = ""
   @State private var split: Int = 1;
   
   var body: some View {
      NavigationView {
         VStack {
            appBar()
            ModifiedBackground {
               GeometryReader { geometry in
                  VStack (alignment: .leading, spacing: 10) {
                     
                     Text("Tip Calculator")
                        .font(.title)
                        .padding(12)
                     
                     InputView(fieldValue: self.$bill,
                               fieldName: "Bill",
                               eventFunction: { self.calculateTotal() })
                     
                     InputView(fieldValue: self.$tip,
                               fieldName: "Tip",
                               eventFunction: { self.calculateTotal() })
                     
                     StepperView(splitValue: self.$split,
                                 fieldName: "Split",
                                 eventFunction: { self.calculateTotal() })
                     
                     InputView(fieldValue: self.$total,
                               fieldName: "Total",
                               isDisabled: true,
                               eventFunction: {nil})
                     
                     NavigationLink(destination: Lesson2View(), label: {
                        Text("Go to Lesson 2")
                           .frame(width: geometry.size.width, alignment: .center)
                           .padding(.top, 20)
                     })
                     
                     Spacer()
                  }
               }
            }
            .onTapGesture {
               UIApplication.shared.endEditing()
            }
         }
      }
      .navigationBarHidden(true)
   }
   
   func calculateTotal(){
      let billDouble: Double = self.bill.isEmpty ? 0.00 : Double(self.bill)!
      let tipDouble: Double = self.tip.isEmpty ? 0.00 : Double(self.tip)!
      
      self.total = "\((billDouble + tipDouble) / Double(self.split))"
   }
}

private struct appBar: View {
   var body: some View {
      VStack {
         HStack {
            Text("Lesson 1")
               .navigationBarTitle("")
               .navigationBarBackButtonHidden(true)
               .navigationBarHidden(true)
               .foregroundColor(Color.white)
            Spacer()
         }
      }
      .padding()
      .background(Color.blue.edgesIgnoringSafeArea(.top).shadow(color: .black, radius: 8))
   }
}

struct InputView: View {
   @Binding var fieldValue: String;
   var fieldName: String;
   var isDisabled: Bool = false
   var eventFunction: () -> Void?
   
   var body: some View {
      HStack (spacing: 40) {
         Text(fieldName)
            .font(.headline)
            .frame(width: 45)
         
         TextField("", text: $fieldValue,
                   onEditingChanged: { _ in self.eventFunction() }) {
                     UIApplication.shared.endEditing()
         }
         .padding(.horizontal, 12)
         .font(.system(size: 20, design: .default))
         .frame(height: 30)
         .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
         .keyboardType(.decimalPad)
         .disabled(isDisabled)
      }
      .padding(.horizontal)
   }
}

struct StepperView: View {
   @Binding var splitValue: Int
   var fieldName: String
   var eventFunction: () -> Void
   
   var body: some View {
      VStack (alignment: .trailing) {
         HStack {
            Text(fieldName)
               .font(.headline)
               .frame(width: 45)
            
            Spacer()
            
            Text("\(self.splitValue)")
               .padding(.trailing, 10)
            
            Button(action: {
               self.splitValue += 1
               self.eventFunction()
               
            }) {
               Image(systemName: "plus.circle.fill")
                  .resizable()
                  .frame(width: 30, height: 30)
            }
            
            Button(action: {
               self.splitValue = self.splitValue <= 1 ?  1 : self.splitValue - 1
               self.eventFunction()
            }) {
               Image(systemName: "minus.circle.fill")
                  .resizable()
                  .frame(width: 30, height: 30)
            }
            
         }
         .padding(.leading, 15)
         .padding(.trailing, 10)
      }
   }
}

struct ModifiedBackground<Content: View>: View {
   private var content: Content
   
   init(@ViewBuilder content: @escaping () -> Content) {
      self.content = content()
   }
   var body: some View {
      GeometryReader { geometry in
         Color.white
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            .overlay(self.content)
      }
      .edgesIgnoringSafeArea(.bottom)
   }
}

extension UIApplication {
   func endEditing() {
      sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}


struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      Lesson1View()
//      Group {
//         Lesson1View()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            .previewDisplayName("iPhone 11")
//
//         Lesson1View()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            .previewDisplayName("iPhone 8")
//      }
   }
}
