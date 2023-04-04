// 꽃말과 함께 내일의 나를 응원하는 앱
// 꽃에 대한 정보와 꽃말을 쓰고 짧은 응원 메시지를 보낸다.
// 지속가능한 꽃과, 지속가능한 나를 응원

import SwiftUI

struct MainIntroView: View {
    @State private var toMainViewTrigger: Bool = false
    
    var body: some View {
        VStack {
            Text("Send Me a Herbs")
                .font(.largeTitle)
            Text("For Tomorrow Me")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
                toMainViewTrigger.toggle()
            }
        }
        .overlay {
            NavigationLink(isActive: $toMainViewTrigger) {
                FMMainView()
                    .navigationBarBackButtonHidden()
            } label: {
                EmptyView()
            }
        }
    }
}
