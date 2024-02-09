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
            Form {
                VStack {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Email", text: $email)
                    Button("Register") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }
                }.navigationDestination(isPresented: $isLoggedIn) {
                    Home()
                }.onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
