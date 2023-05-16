import SwiftUI

struct MainView: View {
  @Namespace var nsArticle
  
  @State private var selectedArticleIndex: Int?
  @State private var showContent = false
  
  var body: some View {
    ZStack(alignment: .top) {
      ScrollView {
        VStack(spacing: 40) {
          TopBarView().padding(.horizontal, 20)
          ForEach(sampleInventory.indices, id: \.self) { index in
            ItemCardView(category: sampleInventory[index].category, headline: sampleInventory[index].headline, subHeadline: sampleInventory[index].subHeadline, image: sampleInventory[index].image, content: sampleInventory[index].content, isShowContent: $showContent)
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
      }.opacity(showContent ? 0 : 1)
          
      if showContent, let selectedArticleIndex {
        ItemCardView(category: sampleInventory[selectedArticleIndex].category, headline: sampleInventory[selectedArticleIndex].headline, subHeadline: sampleInventory[selectedArticleIndex].subHeadline, image: sampleInventory[selectedArticleIndex].image, content: sampleInventory[selectedArticleIndex].content, isShowContent: $showContent)
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
