//
//  Menu.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    func getMenuData() {
        // PersistenceController.shared.clear() // Does not clear?
        // try? viewContext.save()
        
        PersistenceController.shared.clear_all()
        
        let urlstr = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlstr)!
        let urlreq = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlreq) {
            data, response, error in if let data {
                // print(String(decoding: data, as: UTF8.self))
                let jsondec = JSONDecoder()
                let menulist = try? jsondec.decode(MenuList.self, from: data)
                if let menulist {
                    for menuitem in menulist.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuitem.title
                        dish.price = menuitem.price
                        dish.image = menuitem.image
                        dish.category = menuitem.category
                    }
                    try? viewContext.save()
                }
            }
            else {
                print("Oops")
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Dish.title, ascending: true)]
    }
    
    func buildPredicates() -> NSPredicate {
        if searchText.isEmpty {
            NSPredicate(value: true)
        }
        else {
            NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Little Lemon")
                Text("Chicago")
                Text("This is the app for Little Lemon")
            }
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicates(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) {
                        dish in
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                Text((dish.title ?? "") + " : " + (dish.price ?? ""))
                                let url = URL(string: (dish.image ?? ""))
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
        }.onAppear() {
            getMenuData()
        }
    }
}

#Preview {
    Menu()
}
