//
// Home screen which has tabs for menu and profile. Also shows
// onbarding alerts in the first run.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    // TODO: implement a proper onboarding
    @State var showingAlert1:Bool
    @State private var showingAlert2:Bool = false
    @State private var showingAlert3:Bool = false
    
    var body: some View {
        TabView {
            VStack {
                Menu()
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }
            .environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfile()
            .tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }
        .navigationBarBackButtonHidden(true)

        .alert("Welcome to Little Lemon! [step 1/3]",
               isPresented: $showingAlert1,
               presenting: 1,
               actions: { c in
                    Button("Skip", role: .cancel) {}
                    Button("Next") {
                        showingAlert2 = true
                    }
                },
               message: { c in
                Text("To order, first tap a dish to see the dish details and then press the order button on the next screen to place the order.")
                }
        )

        .alert("Welcome to Little Lemon! [step 2/3]",
               isPresented: $showingAlert2,
               presenting: 1,
               actions: { c in
                    Button("Skip", role: .cancel) {}
                    Button("Next") {
                        showingAlert3 = true
                    }
                },
               message: { c in
                Text("You can edit your personal information in the profile screen which you can access from the bottom right corner.")
                }
        )

        .alert("Welcome to Little Lemon! [step 3/3]",
               isPresented: $showingAlert3,
               presenting: 1,
               actions: { c in
                    Button("Done", role: .cancel) {}
                },
               message: { c in
                Text("You can select specific categories to show using the buttons and you can search foods or drinks by name using the search field.")
                }
        )
    }
}

#Preview {
    Home(showingAlert1: true)
}
