//
//  Lesson6View.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 5/4/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson6View: View {
   @Binding var isPresented: Bool
   
   let coreDM: CoreDataManager
   
   @State private var inputItemName = ""
   @State private var inputItemDescription = ""
   
   @State private var savedItems: [SavedItem] = [SavedItem]()
   
   var itemName: String = ""
   var itemDescription: String = ""
   @State var selectedIndex: Int = 0
   
   var body: some View {
      VStack {
         appBar(isPresented: $isPresented)
         HStack (spacing: 20){
            VStack {
               TextField("New Item Name", text: $inputItemName)
               TextField("New Item Description", text: $inputItemDescription)
            }.padding(.leading)
            
            Button(action: {
               self.coreDM.saveNewItem(itemName: self.inputItemName, itemDescription: self.inputItemDescription)
               self.populateList()
            }){
               Image(systemName: "plus.circle.fill")
                  .resizable()
                  .frame(width: 30, height: 30)
            }
            
            Button(action: {
               self.savedItems = self.coreDM.getAllItem()
               self.savedItems[self.selectedIndex].itemName = self.inputItemName
               self.savedItems[self.selectedIndex].itemDescription = self.inputItemDescription
               self.coreDM.updateItem()
               self.populateList()
            }){
               Image(systemName: "pencil.tip.crop.circle")
                  .resizable()
                  .frame(width: 30, height: 30)
            }
         }
         
         List {
            ForEach(Array(savedItems.enumerated()), id: \.offset){ index, item in
               VStack(alignment: .leading) {
                  Text(item.itemName ?? "")
                  Text(item.itemDescription ?? "")
               }.onTapGesture {
                  self.selectedIndex = index
                  self.savedItems = self.coreDM.getAllItem()
                  self.inputItemName = self.savedItems[index].itemName ?? ""
                  self.inputItemDescription = self.savedItems[index].itemDescription ?? ""
               }
            }
            .onDelete(perform: { indexSet in
               indexSet.forEach { index in
                  let saveItem = self.savedItems[index]
                  self.coreDM.deleteMovie(savedItem: saveItem)
                  self.populateList()
               }
            })
         }.padding()
      }.onAppear {
         self.populateList()
      }
   }
   
   func populateList(){
      self.savedItems = []
      self.inputItemName = ""
      self.inputItemDescription = ""
      self.savedItems = coreDM.getAllItem()
   }
}

private struct appBar: View {
   @Binding var isPresented: Bool
   var body: some View {
      HStack {
         Button(action: {
            self.isPresented.toggle()
         }){
            Image(systemName: "chevron.left")
               .foregroundColor(Color.black)
            
         }.padding(.leading)
         
         Text("Lesson 6")
            .font(.headline)
            .fontWeight(.heavy)
            .padding(.vertical)
         Spacer()
      }
   }
}

struct Lesson6View_Previews: PreviewProvider {
   static var previews: some View {
      Lesson6View(isPresented: .constant(true), coreDM: CoreDataManager())
   }
}
