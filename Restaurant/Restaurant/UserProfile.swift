//
//  UserProfile.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName:String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName:String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email:String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var isLoggedIn:Bool = true

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            Header(showProfilePhoto: false)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Personal information")
                    .font(.custom("Karla", size: 18))
                    .bold()

                Text("avatar")
                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Button("Change") {}
                    .font(.custom("Karla", size: 16))
                    .foregroundColor(.white)
                    .background(Color("Primary1"))
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)

                    Button("Remove") {}
                    .font(.custom("Karla", size: 16))
                    .foregroundColor(.black)
                    .background(Color("Primary2"))
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)
                    Spacer()
                }
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
            }.padding()
            
            VStack {
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                .font(.custom("Karla", size: 16))
                .foregroundColor(.black)
                .background(Color("Primary2"))
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.bordered)
                
                HStack {
                    Button("Discard changes") {
                        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                        lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                        email = UserDefaults.standard.string(forKey: kEmail) ?? ""

                    }
                    .font(.custom("Karla", size: 16))
                    .foregroundColor(.black)
                    .background(Color("Secondary3"))
                    .buttonStyle(.bordered)

                    Button("Save changes") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                        }
                    }
                    .font(.custom("Karla", size: 16))
                    .foregroundColor(.white)
                    .background(Color("Primary1"))
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    UserProfile()
}
