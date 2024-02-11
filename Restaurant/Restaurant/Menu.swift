//
// Show the menu screen of the app
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    @State var filter_starters = false
    @State var filter_mains = false
    @State var filter_desserts = false
    @State var filter_drinks = false

    // Load the menu data and replace the dishes in Core Data with that
    func getMenuData() {
        PersistenceController.shared.clear_all()
        
        // TODO: this should be in a suitable configuration place
        let urlstr = "https://raw.githubusercontent.com/ssarkka/littlelemon/main/data/menu.json"
        
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
                        dish.title = menuitem.name
                        dish.price = String(menuitem.price)
                        dish.desc = menuitem.description
                        dish.image = menuitem.image
                        dish.category = menuitem.category
                    }
                    PersistenceController.shared.save()
                }
            }
            else {
                // TODO: should handle error properly
                print("Oops")
            }
        }
        task.resume()
    }
    
    // Build descriptor to sort by name in case-insensitve and international manner
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString .localizedCaseInsensitiveCompare))]
    }
    
    // Build descriptors to filter by search string and buttons
    func buildPredicates() -> NSPredicate {
        var searchPredicate:NSPredicate
        
        if searchText.isEmpty {
            searchPredicate = NSPredicate(value: true)
        }
        else {
            searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        
        var filterPredicates:[NSPredicate] = []
        if filter_starters {
            filterPredicates.append(NSPredicate(format: "category == \"starters\""))
        }
        if filter_mains {
            filterPredicates.append(NSPredicate(format: "category == \"mains\""))
        }
        if filter_desserts {
            filterPredicates.append(NSPredicate(format: "category == \"desserts\""))
        }
        if filter_drinks {
            filterPredicates.append(NSPredicate(format: "category == \"drinks\""))
        }

        if filterPredicates.count > 0 {
            return NSCompoundPredicate(type: .and, subpredicates: [
                searchPredicate,
                NSCompoundPredicate(type: .or, subpredicates: filterPredicates)])
        }

        return searchPredicate
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Header(showProfilePhoto: true)
                Hero(searchString: $searchText, hasSearchField: true)
                
                VStack(alignment: .leading) {
                    Text("ORDER FOR DELIVERY!")
                        .font(.custom("Karla", size: 18))
                        .fontWeight(.heavy)
                    
                    let inact_fg = Color("Primary1")
                    let inact_bg = Color("Secondary3")
                    let act_bg = Color("Primary1")
                    let act_fg = Color("Secondary3")

                    HStack {
                        Button("Starters") {
                            filter_starters.toggle()
                        }
                        .font(.custom("Karla", size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(filter_starters ? act_fg : inact_fg)
                        .background(filter_starters ? act_bg : inact_bg)
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)
                        
                        Button("Mains") {
                            filter_mains.toggle()
                        }
                        .font(.custom("Karla", size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(filter_mains ? act_fg : inact_fg)
                        .background(filter_mains ? act_bg : inact_bg)
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)

                        Button("Desserts") {
                            filter_desserts.toggle()
                        }
                        .font(.custom("Karla", size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(filter_desserts ? act_fg : inact_fg)
                        .background(filter_desserts ? act_bg : inact_bg)
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)

                        Button("Drinks") {
                            filter_drinks.toggle()
                        }
                        .font(.custom("Karla", size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(filter_drinks ? act_fg : inact_fg)
                        .background(filter_drinks ? act_bg : inact_bg)
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)
                    }

                }.padding()
                
                Divider().frame(height: 2).overlay(Color("Primary1"))

                // TODO: this should be in a suitable configuration place
                let urlstr = "https://raw.githubusercontent.com/ssarkka/littlelemon/main/data/"
                            
                VStack {
                    FetchedObjects(predicate: buildPredicates(),
                                   sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        ScrollView {
                            VStack {
                                ForEach(dishes) {
                                    dish in
                                    NavigationLink(destination: DishDetails(dish: dish)) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 15) {
                                                Text(dish.title ?? "")
                                                    .font(.custom("Karla", size: 18))
                                                    .bold()
                                                    .foregroundColor(.black)
                                                Text(dish.desc ?? "")
                                                    .multilineTextAlignment(.leading)
                                                    .font(.custom("Karla", size: 16))
                                                    .foregroundColor(Color("Primary1"))
                                                    .lineLimit(2)
                                                Text((dish.price ?? "") + "€")
                                                    .font(.custom("Karla", size: 18))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color("Primary1"))
                                            }
                                            Spacer()
                                            let url = URL(string: urlstr + (dish.image ?? ""))
                                            AsyncImage(url: url) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 100, height: 100)
                                        }
                                    }
                                    Divider().frame(height: 1).overlay(Color("Primary1"))
                                }
                            }.padding()
                        }
                    }.onAppear() {
                        getMenuData()
                    }
                }
            }
        }
    }
}

// Preview which creates a Core Data container on the fly
#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
