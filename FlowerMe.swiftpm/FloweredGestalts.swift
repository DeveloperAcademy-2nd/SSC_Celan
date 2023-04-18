import SwiftUI

@main
struct MyApp: App {
    @ObservedObject var gestaltVM: GestaltVM = GestaltVM()
    
    var body: some Scene {
        WindowGroup {
            MainIntroView(gestaltVM: gestaltVM)
        }
    }
}
