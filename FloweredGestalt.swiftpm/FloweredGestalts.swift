import SwiftUI

@main
struct FloweredGestalt: App {
    @ObservedObject var gestaltVM: GestaltVM = GestaltVM()
    
    var body: some Scene {
        WindowGroup {
            MainIntroView(gestaltVM: gestaltVM)
        }
    }
}
