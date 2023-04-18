import SwiftUI

struct MainGridView: View {
    @ObservedObject var gestaltVM: GestaltVM
    @State private var selection: Int = 0
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
                .padding(.vertical, 32)
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
            Text("From Here, You can choose which principle to learn first.")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                
            Text("The more principles you learn, the more colorful the app will be.")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                
            Text("Once you learn principle through interaction, \n🎯 icon turns into a Flower icon like 🌺, 🌼")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("And after you've done an interaction, \nYou should tap a Flower icon inside the dashed line.")
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(gestaltVM.clearedPrinciples.count) down, \(6 - gestaltVM.clearedPrinciples.count) to go.")
                .bold()
                .font(.title3)
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
                    
                    Spacer()
                    
                    Group {
                        Text("The gestalt principle of")
                        
                        Text("**\(gestalt)**")
                    }
                    .font(.title2)
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
