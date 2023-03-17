//

import SwiftUI

@main
struct sm_osx_updaterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400, idealWidth: 400, maxWidth: 400, minHeight: 100, idealHeight: 100, maxHeight: 100)
        }.windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
