//
//  Lesson5View.swift
//  SwiftUI-Studyguide
//
//  Created by Timothy Ercia on 5/4/21.
//  Copyright © 2021 Timothy Ercia. All rights reserved.
//

import SwiftUI

struct Lesson5View: View {
   @State var albums: [Album] = []
   
    var body: some View {
      VStack (alignment: .leading){
         Text("Dynamic List")
            .font(.largeTitle)
            .padding()
         List(albums){ item in
            HStack {
               Image(uiImage: "\(item.thumbnailUrl)".load())
               VStack {
                  Text(item.title).font(.headline)
                  Text(item.url)
               }
            }
         }
      }.onAppear {
         APICollection().getAllAlbums { (res) in
            self.albums = res
         }
      }
    }
}

extension String {
   func load() -> UIImage {
      do {
         guard let url = URL(string: self) else { return UIImage() }
         let data: Data = try Data(contentsOf: url)
         return UIImage(data: data) ?? UIImage()
      } catch {
         
      }
      return UIImage()
   }
}


struct Lesson5View_Previews: PreviewProvider {
    static var previews: some View {
        Lesson5View()
    }
}
