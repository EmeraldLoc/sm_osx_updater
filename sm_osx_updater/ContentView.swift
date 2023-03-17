//

import SwiftUI

struct ContentView: View {
    
    func update(_ waitTillExit: Bool = true) throws {
        let task = Process()
        var output = ""
        
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.arguments = ["-cl", "cd ~/Downloads && rm -rf sm_osx.app && curl -LO https://github.com/EmeraldLoc/sm_osx/releases/latest/download/sm_osx.zip && unzip sm_osx.zip && rm -rf sm_osx.zip /Applications/sm_osx.app __MACOSX && mv sm_osx.app /Applications && open /Applications/sm_osx.app && echo Finished Updating, quit this"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        let outHandle = pipe.fileHandleForReading
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding.utf8) {
                // Update your view with the new text here
                
                output.append(line)
                
                print(output)
                
                if output.contains("Finished Updating, quit this") {
                    exit(0)
                }
            } else {
                print("Error decoding data. why do I program...: \(pipe.availableData)")
            }
        }
        
        try task.run()
        if waitTillExit {
            task.waitUntilExit()
        }
    }
    
    var body: some View {
        VStack {
            Text("Updating...")
                .padding()
            
            ProgressView()
                .progressViewStyle(.linear)
                .padding([.bottom, .horizontal])
        }.onAppear {
            try? update()
        }
    }
}
