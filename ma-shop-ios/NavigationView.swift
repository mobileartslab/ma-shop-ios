import SwiftUI

class Screens: ObservableObject {
    @Published var currentScreen = 1
}

struct NavigationView: View {
  @StateObject var screens = Screens()
  var body: some View {
    ZStack {
      switch screens.currentScreen {
        case 1:
        LoginView(screens:screens)
        case 2:
          MainView()
        default:
          LoginView(screens:screens)
      }
    }
  }
}
