import SwiftUI

struct MainGridView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var selection: Int = 0
    @State private var isSureReset: Bool = false
    
    let gridSystem: [GridItem] = Array(
        repeating: GridItem.init(
            .flexible(
                minimum: 150, maximum: Constants.ReactiveCGFloat.REACTIVE_WIDTH / 3
            )
        ),
        count: 3
    )
    
    var body: some View {
        ScrollView {
            if gestaltVM.clearedPrinciples.count != 6 {
                descriptionBuild()
            } else {
                Text("Congratulation! You've done all the principles!")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Divider()
                .padding(.bottom, 32)
                .padding()
            
            LazyVGrid(
                columns: gridSystem,
                spacing: 30
            ) {
                ForEach(
                    0..<Constants.Gestalt.GESTALT_THEORIES.count,
                    id: \.self
                ) { index in
    //                    "❖ Proximity", // garden
    //                    "👯 Similarity", // sunflower
    //                    "➿ Continuity", // rosex
    //                    "🧩 Closure", // tulip
    //                    "😶‍🌫️ Figure/Ground", // sakura
    //                    "❅ Prägnanz" // hibiscus
                    switch Constants.Gestalt.GESTALT_THEORIES[index] {
                    case Constants.Gestalt.PROXIMITY:
                        NavigationLink {
                            ProximityView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PROXIMITY) ? "💐" : "🎯",
                                gestalt: Constants.Gestalt.PROXIMITY
                            )
                        }
                        
                    case Constants.Gestalt.SIMILARITY:
                        NavigationLink {
                            SimilarityView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.SIMILARITY) ? "🌼" : "🎯",
                                gestalt: Constants.Gestalt.SIMILARITY
                            )
                        }
                    
                    case Constants.Gestalt.CONTINUITY:
                        NavigationLink {
                            ContinuationView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CONTINUITY) ? "🥀" : "🎯",
                                gestalt: Constants.Gestalt.CONTINUITY
                            )
                        }
                        
                    case Constants.Gestalt.CLOSURE:
                        NavigationLink {
                            ClosureView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.CLOSURE) ? "🌷" : "🎯",
                                gestalt: Constants.Gestalt.CLOSURE
                            )
                        }
                        
                    case Constants.Gestalt.FIGUREGROUND:
                        NavigationLink {
                            FigureGroundView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.FIGUREGROUND) ? "🌸" : "🎯",
                                gestalt: Constants.Gestalt.FIGUREGROUND
                            )
                        }
                        
                    case Constants.Gestalt.PRAGNANZ:
                        NavigationLink {
                            PragnanzView(gestaltVM: gestaltVM)
                        } label: {
                            GridGestalts(
                                gestaltVM: gestaltVM,
                                flower: gestaltVM.clearedPrinciples.contains(Constants.Gestalt.PRAGNANZ) ? "🌺" : "🎯",
                                gestalt: Constants.Gestalt.PRAGNANZ
                            )
                        }
                   
                    default:
                        Text("")
                    }
                }
            }
            
            if gestaltVM.clearedPrinciples.count == 6 {
                Text("You've exprienced basics of The Gestalt Principles!")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("If you want to restart, press the Reset Button!")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if !isSureReset {
                    // MARK: - RESET
                    Button {
                        withAnimation {
                            isSureReset.toggle()
                        }
                    } label: {
                        Text("Reset")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    VStack {
                        Text("Are You sure?")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        HStack {
                            Button {
                                withAnimation {
                                    isSureReset.toggle()
                                }
                            } label: {
                                Text("No")
                                    .bold()
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            
                            // MARK: - RESET
                            NavigationLink {
                                MainGuideView(gestaltVM: GestaltVM())
                                    .navigationBarBackButtonHidden()
                            } label: {
                                Text("Reset")
                                    .bold()
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        
                    }
                    
                }
                
            } else {
                VStack {
                    Text("Once you learn principle through interaction, \n🎯 icon turns into a Flower icon like 🌺, 🌼")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("And after you've done an interaction, \nYou should tap a **Flower icon inside the dashed line** to finish the interaction.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    
                    Text("You've done \(gestaltVM.clearedPrinciples.count) principles, \nand you have \(6 - gestaltVM.clearedPrinciples.count) to go.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding(.top, 32)
            }
        }
        .overlay {
            if gestaltVM.clearedPrinciples.count == 6 {
                MiniFlower(tintColor: .yellow, budColor: .white, radian: 2)
                    .modifier(ParticlesModifier(numberOfParticles: 10))
                
                FivePetalsFlower(petalOffset: 0, petalWidth: 40)
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .modifier(ParticlesModifier(numberOfParticles: 10))
                
                TransformableFlower(
                    petalOffset: 0,
                    petalWidth: 20
                )
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .modifier(ParticlesModifier(numberOfParticles: 10))
                
                FMFlower(tintColor: .orange, budColor: .yellow)
                    .scaleEffect(0.5)
                    .modifier(ParticlesModifier(numberOfParticles: 10))
                
                Text("🌺")
                    .font(.largeTitle)
                    .modifier(ParticlesModifier())
                
                Text("🌼")
                    .font(.largeTitle)
                    .modifier(ParticlesModifier())
                
                Text("🌸")
                    .font(.largeTitle)
                    .modifier(ParticlesModifier())
            }
        }
    }
    
    private func descriptionBuild() -> some View {
        VStack {
            Text("From Here, You can choose which principle to learn.")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Text("The more principles you learn, the more colorful the app will be.")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        MainGridView(gestaltVM: GestaltVM())
    }
}

struct GridGestalts: View {
    @ObservedObject var gestaltVM: GestaltVM
    let flower: String
    let gestalt: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(
                gestaltVM.clearedPrinciples.contains(gestalt)
                ? LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .red,
                            Color(
                                red: 253/255,
                                green: 61/255,
                                blue: 86/255
                            ),
                            Color(
                                red: 253/255,
                                green: 185/255,
                                blue: 109/255
                            )
                        ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                : LinearGradient(
                    colors: [
                        Color(.systemGray6),
                        Color(.systemGray4),
                        Color(.systemGray2),
                        Color(.systemGray),
                        .white
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 300, height: 300)
            .padding(.horizontal, 30)
            .shadow(radius: 10)
            .overlay {
                VStack {
                    Text(flower)
                        .font(.system(size: 50))
                        .shadow(radius: 5)
                        .padding(.bottom, 32)
                    
                    Text("The gestalt principle of")
                        .foregroundColor(.white)
                    
                    Text("**\(gestalt)**")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if gestaltVM.clearedPrinciples.contains(gestalt) {
                        Text("✅")
                            .font(.title2)
                    }
                }
                .padding()
            }
    }
}
