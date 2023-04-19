//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/19.
//

import SwiftUI

struct MainGuideView: View {
    @State private var toMainViewTrigger: Bool = false
    @ObservedObject var gestaltVM: GestaltVM
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Flowered Gestalts")
                        .font(.largeTitle)
                    
                    Text("To Understand How we see and recognize things.")
                }
                .padding()
                
                VStack(alignment: .leading) {
                    ForEach(
                        0..<Constants.INTRO_ONBOARDING.count, id: \.self
                    ) { index in
                        if index < Constants.INTRO_ONBOARDING.count - 1 {
                            Text(Constants.INTRO_ONBOARDING[index])
                                .font(.title)
                                .padding()
                        }
                    }
                }
                
                NavigationLink {
                    MainGridView(gestaltVM: gestaltVM)
                } label: {
                    Text("Next")
                        .font(.title)
                        .padding()
                }
                .padding(.top, 32)
                .buttonStyle(.borderedProminent)
            }
            .padding(.top, 32)
            .frame(
                maxWidth: .infinity,
                alignment: .center
            )
        }
    }
    
    private func getPadding() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width / 8
        } else {
            return 0
        }
    }
}

struct PreviewGuide: PreviewProvider {
    static var previews: some View {
        MainGuideView(gestaltVM: GestaltVM())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
