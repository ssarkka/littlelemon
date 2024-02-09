//
//  UserProfile.swift
//  Restaurant
//
//  Created by Simo Särkkä on 8.2.2024.
//

import SwiftUI

struct UserProfile: View {
    private let firstName:String? = UserDefaults.standard.string(forKey: kFirstName)
    private let lastName:String? = UserDefaults.standard.string(forKey: kLastName)
    private let email:String? = UserDefaults.standard.string(forKey: kEmail)

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName ?? "(first name empty)")
            Text(lastName ?? "(last name empty)")
            Text(email ?? "(email empty)")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
