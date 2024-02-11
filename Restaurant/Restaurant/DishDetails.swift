//
// This is a Swift View for showing the information of one dish
// proving a button to order it. In a real applition the order
// button would probably add the item to the shopping cart.
//

import SwiftUI

struct DishDetails: View {
    @State private var showingAlert = false
    let dish:Dish
    
    var body: some View {
        VStack(spacing: 0) {
            Header(showProfilePhoto: true)
            Hero(searchString: Binding.constant(""), hasSearchField: false)

            // TODO: this should be in a suitable configuration place
            let urlstr = "https://raw.githubusercontent.com/ssarkka/littlelemon/main/data/"
            
            VStack {
                Text(dish.title ?? "")
                    .font(.custom("Karla", size: 18))
                    .bold()
                    .foregroundColor(.black)
                
                Text("Category: " + (dish.category ?? ""))
                    .font(.custom("Karla", size: 16))
                    .foregroundColor(Color("Primary1"))

                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(dish.desc ?? "")
                            .multilineTextAlignment(.leading)
                            .font(.custom("Karla", size: 16))
                            .foregroundColor(Color("Primary1"))
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
            }.padding()
            
            Button("Order now!") {
                showingAlert = true
            }
            .foregroundColor(.black)
            .background(Color("Primary2"))
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.bordered)
            .alert("Order placed!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            Spacer()
        }
    }
}


// Custom preview which creates single dish to Core Data
struct DishDetails_Previews: PreviewProvider {
    static let persistence = PersistenceController.shared

    static var previews: some View {
        let dish = Dish(context: persistence.container.viewContext)
        dish.title = "Greek Salad"
        dish.price = "12.99"
        dish.desc = "Our delicious salad is served with Feta cheese and peeled cucumber. Includes tomatoes, onions, olives, salt and oregano in the ingredients."
        dish.image = "greek_salad.png"
        dish.category = "starters"
        
        return DishDetails(dish: dish)
    }
}
