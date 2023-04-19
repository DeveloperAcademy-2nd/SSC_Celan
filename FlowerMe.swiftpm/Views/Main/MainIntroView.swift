import SwiftUI

struct MainIntroView: View {
    @State private var toMainViewTrigger: Bool = false
    @ObservedObject var gestaltVM: GestaltVM
    
    var body: some View {
        NavigationView {
            FMCustomCardView(style: .normal()) {
                VStack {
                    Spacer()
                    
                    Text("Flowered Gestalts")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    Text("To Understand How we see and recognize things.")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.black).opacity(0.8)
                    
                    Spacer()
                    
                    NavigationLink {
                        MainGuideView(gestaltVM: gestaltVM)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Let's Begin!")
                            .padding()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .background {
                ForEach(0..<35, id: \.self) { index in
                    MiniFlower(
                        tintColor: .yellow,
                        budColor: .white,
                        radian: 2
                    )
                    .position(
                        CGPoint(
                            x: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_WIDTH...Constants.ReactiveCGFloat.REACTIVE_WIDTH),
                            y: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_HEIGHT...Constants.ReactiveCGFloat.REACTIVE_HEIGHT)
                        )
                    )
                    .rotationEffect(
                        .degrees(
                            Double.random(in: 30...180)
                        )
                    )
                    
                    FMFlower(tintColor: .orange, budColor: .yellow)
                        .position(
                            CGPoint(
                                x: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_WIDTH...Constants.ReactiveCGFloat.REACTIVE_WIDTH),
                                y: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_HEIGHT...Constants.ReactiveCGFloat.REACTIVE_HEIGHT)
                            )
                        )
                        .rotationEffect(
                            .degrees(
                                Double.random(in: 30...180)
                            )
                        )
                    
                    FMFlower(tintColor: .yellow, budColor: .brown)
                        .position(
                            CGPoint(
                                x: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_WIDTH...Constants.ReactiveCGFloat.REACTIVE_WIDTH),
                                y: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_HEIGHT...Constants.ReactiveCGFloat.REACTIVE_HEIGHT)
                            )
                        )
                        .rotationEffect(
                            .degrees(
                                Double.random(in: 30...180)
                            )
                        )
                    
                    TransformableFlower(
                        petalOffset: 0,
                        petalWidth: 20
                    )
                    .fill(Color.purple)
                    .frame(width: 100, height: 100)
                    .position(
                        CGPoint(
                            x: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_WIDTH...Constants.ReactiveCGFloat.REACTIVE_WIDTH),
                            y: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_HEIGHT...Constants.ReactiveCGFloat.REACTIVE_HEIGHT)
                        )
                    )
                    .rotationEffect(
                        .degrees(
                            Double.random(in: 30...180)
                        )
                    )
                    
                    FivePetalsFlower(
                        petalOffset: -5,
                        petalWidth: 150
                    )
                    .fill(Color.red)
                    .position(
                        CGPoint(
                            x: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_WIDTH...Constants.ReactiveCGFloat.REACTIVE_WIDTH),
                            y: CGFloat.random(in: -Constants.ReactiveCGFloat.REACTIVE_HEIGHT...Constants.ReactiveCGFloat.REACTIVE_HEIGHT)
                        )
                    )
                    .rotationEffect(
                        .degrees(
                            Double.random(in: 30...180)
                        )
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func getPadding() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width / 8
        } else {
            return 0
        }
    }
}
