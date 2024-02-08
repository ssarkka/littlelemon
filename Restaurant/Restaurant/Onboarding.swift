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

struct Onboarding: View {
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var email:String = ""
    
    var body: some View {
        
        Form{
            VStack {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if !firstName.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                    }
                    if !lastName.isEmpty {
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                    }
                    if !email.isEmpty {
                        UserDefaults.standard.set(email, forKey: kEmail)
                    }
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
