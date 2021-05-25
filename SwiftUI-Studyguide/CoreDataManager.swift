//
//  CoreDataManager.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 5/11/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
   let persistentContainer: NSPersistentContainer
   
   init(){
      persistentContainer = NSPersistentContainer(name: "CoreDataStudyGuide")
      persistentContainer.loadPersistentStores { (description, error) in
         if let error = error {
            fatalError("Has error \(error.localizedDescription)")
         }
      }
   }
   
   func saveNewItem(itemName: String, itemDescription: String){
      let item = SavedItem(context: persistentContainer.viewContext)
      item.itemName = itemName
      item.itemDescription = itemDescription
      
      do {
         try persistentContainer.viewContext.save()
      } catch {
         print(error)
      }
   }
   
   func getAllItem() -> [SavedItem] {
      let fetchRequest: NSFetchRequest<SavedItem> = SavedItem.fetchRequest();
      
      do {
         return try persistentContainer.viewContext.fetch(fetchRequest)
      } catch {
         print(error)
         return []
      }
   }
   
   func updateItem(){
      do {
         try persistentContainer.viewContext.save()
      } catch {
         persistentContainer.viewContext.rollback()
         print(error)
      }
   }
   
   func deleteMovie(savedItem: SavedItem){
      persistentContainer.viewContext.delete(savedItem)
      do {
         try persistentContainer.viewContext.save()
      } catch {
         persistentContainer.viewContext.rollback()
         print(error)
      }
   }
}
