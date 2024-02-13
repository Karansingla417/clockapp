//
//  Mainview.swift
//  clockapp
//
//  Created by Karan Singla on 02/02/24.
//

import SwiftUI

struct Mainview: View {
    var body: some View {
        TabView{
            Stopwatchview()
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Stopwatch")
                }
            Alarmview()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Alarm")
                }
            Timerview()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
        }
    }
}

#Preview {
    Mainview()
}
