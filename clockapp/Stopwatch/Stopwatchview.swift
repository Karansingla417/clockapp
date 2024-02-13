import SwiftUI

struct Stopwatchview: View {
    @State private var time = 0.0
    @State private var isRunning = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(time, specifier: "%.1f")")
                .foregroundColor(.white)
                .font(.system(size: 50))
                .padding()
            
            HStack{
                Button(action: {
                    time = 0.0
                    isRunning = false
                }, label: {
                    Circle()
                        .frame(width:90, height: 90)
                        .foregroundColor(.gray)
                        .overlay(
                            Text("Reset")
                                .foregroundColor(.white)
                                .bold()
                        )
                    
                })
                .padding()
                
                Spacer()
                
                Button(action: {
                    isRunning.toggle()
                }, label: {
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundColor(isRunning ? .red : .green)
                        .overlay(
                            Text(isRunning ? "Stop" : "Start")
                                .foregroundColor(.white)
                                .bold()
                        )
                })
                .padding()
            }
            
        }
        .preferredColorScheme(.dark)
        .onReceive(timer, perform: { _ in
            if isRunning {
                time += 0.1
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatchview()
    }
}

