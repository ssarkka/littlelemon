//
// A component which shows the logo and description (the hero-section)
// along with an optional search field.
//

import SwiftUI

struct Hero: View {
    @Binding var searchString:String
    let hasSearchField:Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Little lemon")
                    .foregroundStyle(Color("Primary2"))
                    .font(.custom("Markazi Text", size: 64))
                    .fontWeight(.medium)
                    .frame(height: 40)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Chicago")
                            .foregroundStyle(Color("Secondary3"))
                            .font(.custom("Markazi Text", size: 40))
                            .fontWeight(.regular)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist.")
                            .foregroundStyle(Color("Secondary3"))
                            .font(.custom("Karla", size: 16))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    Image("hero-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 110, height: 110, alignment: .topLeading)
                        .cornerRadius(10)
                }

                if hasSearchField {
                    Spacer().frame(height: 10)
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

// Default preview
#Preview {
    Hero(searchString: Binding.constant(""), hasSearchField: true)
}
