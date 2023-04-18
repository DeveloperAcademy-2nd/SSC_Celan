import SwiftUI

@main
struct FloweredGestalts: App {
    @ObservedObject var gestaltVM: GestaltVM = GestaltVM()
    
    var body: some Scene {
        WindowGroup {
            MainIntroView(gestaltVM: gestaltVM)
        }
    }
}
