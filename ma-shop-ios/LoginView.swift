import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
  @State var username: String = ""
  @State var password: String = ""
  
  var isSignInButtonDisabled: Bool {
    [username, password].contains(where: \.isEmpty)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        WelcomeText()
        UserImage()
        
        TextField("Username", text: $username)
          .padding()
          .background(lightGreyColor)
          .cornerRadius(5.0)
          .padding(.bottom, 20)
        
        SecureField("Password", text: $password)
          .padding()
          .background(lightGreyColor)
          .cornerRadius(5.0)
          .padding(.bottom, 20)
        
        NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
          Button(action: {print("Button tapped")}) {
            LoginButtonContent()
          }.disabled(isSignInButtonDisabled)
        }
      }
      .padding()
      
    }
  }
}
  
struct WelcomeText : View {
  var body: some View {
    return Text("Shopper")
      .font(.largeTitle)
      .fontWeight(.semibold)
      .padding(.bottom, 20)
    }
}

struct UserImage : View {
  var body: some View {
    return Image("appLogo")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 150, height: 150)
      .padding(.bottom, 75)
  }
}

struct LoginButtonContent : View {
  var body: some View {
    return Text("LOGIN")
      .font(.headline)
      .foregroundColor(.white)
      .padding()
      .frame(width: 220, height: 60)
      .background(Color.green)
      .cornerRadius(15.0)
  }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
#endif
