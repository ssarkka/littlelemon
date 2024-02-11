//
//  Hero.swift
//  Restaurant
//
//  Created by Simo Särkkä on 10.2.2024.
//

import SwiftUI

struct Hero: View {
    @Binding var searchString:String
    let hasSearchField:Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .foregroundColor(Color("Primary2"))
                    .font(.custom("Markazi Text", size: 64))
                    .fontWeight(.medium)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Chicago")
                            .foregroundColor(Color("Secondary3"))
                            .font(.custom("Markazi Text", size: 40))
                            .fontWeight(.regular)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist.")
                            .foregroundColor(Color("Secondary3"))
                            .font(.custom("Karla", size: 16))
                            .fontWeight(.regular)
                    }
                    Image("hero-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120, alignment: .topLeading)
                        .cornerRadius(15)
                }

                if hasSearchField {
                    Spacer().frame(height: 5)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search ...", text: $searchString)
                            .background()
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }.padding()
            
        }.background(Color("Primary1"))
    }
}

#Preview {
    Hero(searchString: Binding.constant(""), hasSearchField: true)
}
