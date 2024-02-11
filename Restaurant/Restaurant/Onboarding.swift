//
//  Onboarding.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
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
    
    var body: some View {
        NavigationStack {
            Header(showProfilePhoto: false)
            Hero(searchString: Binding.constant(""), hasSearchField: false)
            VStack {
                VStack(alignment: .leading) {
                    Text("First name*")
                    TextField("First name", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                    Text("Last name*")
                    TextField("Last name", text: $lastName)
                    Text("Email*")
                    TextField("Email", text: $email)
                        .font(.custom("Karla", size: 16))
                }
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
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
                Home()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
