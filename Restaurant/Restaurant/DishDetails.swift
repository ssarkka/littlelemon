//
//  DishDetails.swift
//  Restaurant
//
//  Created by Simo Särkkä on 11.2.2024.
//

import SwiftUI

struct DishDetails: View {
    let dish:Dish
    
    var body: some View {
        VStack(spacing: 0) {
            Header(showProfilePhoto: true)
            Hero(searchString: Binding.constant(""), hasSearchField: false)

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
            }
            .foregroundColor(.black)
            .background(Color("Primary2"))
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.bordered)
            Spacer()
        }
    }
}

