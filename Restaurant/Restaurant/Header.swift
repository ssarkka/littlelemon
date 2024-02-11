//
// This is the top header of the app, currently purely visual element.
//

import SwiftUI

struct Header: View {
    var showProfilePhoto = true
    
    var body: some View {
            ZStack {
                Image("little-lemon-logo")
                    .frame(height: 40, alignment: .topLeading)
                if showProfilePhoto {
                    HStack(spacing: 0) {
                        Spacer()
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .topLeading)
                    }.padding()
                }
            }
    }
}

// Default preview
#Preview {
    Header()
}
