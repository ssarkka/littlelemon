//
//  Header.swift
//  Restaurant
//
//  Created by Simo Särkkä on 10.2.2024.
//

import SwiftUI

struct Header: View {
    var showProfilePhoto = true
    
    var body: some View {
            ZStack {
                Image("little-lemon-logo")
                    .frame(width: .infinity, height: 50, alignment: .topLeading)
                if showProfilePhoto {
                    HStack {
                        Spacer()
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .topLeading)
                    }.padding()
                }
            }
    }
}

#Preview {
    Header()
}
