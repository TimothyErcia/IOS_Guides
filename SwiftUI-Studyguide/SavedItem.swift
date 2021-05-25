//
//  SavedItem.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 5/6/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
   let persistentContainer: NSPersistentContainer
   
   init(){
      persistentContainer = NSPersistentContainer(name: "CoreDataStudyGuide")
      persistentContainer.loadPersistentStores { (description, error) in
         if let error = error {
            fatalError("Core data \(error.localizedDescription)")
         }
      }
   }
   
   
   
   
}
