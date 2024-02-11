//
// Obboarding screen which asks for login information
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var email:String = ""
    
    @State private var isLoggedIn:Bool = false
    @State private var firstTime = true
    
    var body: some View {
        NavigationStack {
            Header(showProfilePhoto: false)
            Hero(searchString: Binding.constant(""), hasSearchField: false)
            VStack {
                VStack(alignment: .leading) {
                    Text("First name*")
                        .font(.custom("Karla", size: 16))
                        .bold()
                    TextField("First name", text: $firstName)
                        .font(.custom("Karla", size: 16))
                        .textFieldStyle(.roundedBorder)
                        .border(Color("Secondary4"))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Text("Last name*")
                        .font(.custom("Karla", size: 16))
                        .bold()
                    TextField("Last name", text: $lastName)
                        .font(.custom("Karla", size: 16))
                        .textFieldStyle(.roundedBorder)
                        .border(Color("Secondary4"))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Text("Email*")
                        .font(.custom("Karla", size: 16))
                        .bold()
                    TextField("Email", text: $email)
                        .font(.custom("Karla", size: 16))
                        .textFieldStyle(.roundedBorder)
                        .border(Color("Secondary4"))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        firstTime = true
                        isLoggedIn = true
                    }
                }
                .font(.custom("Karla", size: 16))
                .foregroundColor(.black)
                .background(Color("Primary2"))
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                Home(showingAlert1: firstTime)
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                    firstTime = false
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
