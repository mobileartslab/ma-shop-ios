import SwiftUI

struct MainView: View {
  @Namespace var nsArticle
  
  @State private var selectedArticleIndex: Int?
  @State private var showContent = false
  @State private var inventories: [StoreInventory] = []

  private func fetchRemoteData() {
    let url = URL(string: "http://192.168.86.21:8000/api/public/getInventory")!
    var request = URLRequest(url: url)
      request.httpMethod = "GET"  // optional
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      let task = URLSession.shared.dataTask(with: request){ data, response, error in
      if let error = error {
        print("Error while fetching data:", error)
        return
      }
      guard let data = data else {
        return
      }
      do {
        let inventoryData = try JSONDecoder().decode(InventoryData.self, from: data)
        self.inventories = inventoryData.result
      } catch let jsonError {
        print("Failed to decode json", jsonError)
      }
    }
    task.resume()
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      ScrollView {
        VStack(spacing: 40) {
          TopBarView().padding(.horizontal, 20)
            ForEach(inventories.indices, id: \.self) { index in
            ItemCardView(
              category: inventories[index].category,
              headline: inventories[index].headline,
              subheadline: inventories[index].subheadline,
              image: inventories[index].image,
              content: inventories[index].content,
              isShowContent: $showContent
            )
            .padding(.horizontal, 20)
            .matchedGeometryEffect(id: index, in: nsArticle)
            .onTapGesture {
               withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.65, blendDuration: 0.1)) {
                self.selectedArticleIndex = index
                self.showContent.toggle()
              }
            }.frame(height: min(sampleInventory[index].image.size.height/3, 500))
          }
        }
      }
      .opacity(showContent ? 0 : 1)
      .onAppear {
         fetchRemoteData()
      }
          
      if showContent, let selectedArticleIndex {
        ItemCardView(
          category: inventories[selectedArticleIndex].category,
          headline: inventories[selectedArticleIndex].headline,
          subheadline: inventories[selectedArticleIndex].subheadline,
          image: inventories[selectedArticleIndex].image,
          content: inventories[selectedArticleIndex].content,
          isShowContent: $showContent
        )
        .matchedGeometryEffect(id: selectedArticleIndex, in: nsArticle)
        .ignoresSafeArea()
        }
     }
  }

}



struct TopBarView : View {
  var body: some View {
    HStack(alignment: .lastTextBaseline) {
      VStack(alignment: .leading) {
        Text(getCurrentDate().uppercased()).font(.caption).foregroundColor(.secondary)
        Text("Today").font(.largeTitle).fontWeight(.heavy)
      }
      Spacer()
      AvatarView(image: "jack", width: 40, height: 40)
    }
  }
    
  func getCurrentDate(with format: String = "EEEE, MMM d") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: Date())
  }
}


struct AvatarView: View {
  let image: String
  let width: CGFloat
  let height: CGFloat
    
  var body: some View {
    Image(image)
      .resizable()
      .frame(width: width, height: height)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.gray, lineWidth: 1))
  }
}

struct StoreInventory: Codable, Identifiable {
  let id: Int
  let category: String
  let headline: String
  let subheadline: String
  let content: String
  let image: String
}
                                                      
struct InventoryData: Codable {
  var result: [StoreInventory]
}
