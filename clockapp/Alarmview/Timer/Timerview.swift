//
//  Timerview.swift
//  clockapp
//
//  Created by Karan Singla on 03/02/24.
//

import SwiftUI

struct Timerview: View {
    
    @State private var selectedhours=0
    @State private var selectedminutes=0
    @State private var selectedseconds=0
    @State private var showpicker=true
    @State private var remainingtime=TimeInterval(0)
    @State private var timerrunning=false
    
    let timer=Timer.publish(every: 1,on: .main, in: .common)
        .autoconnect()
    
    
    
    var body: some View {
        VStack{
            if showpicker{
                HStack{
                    Picker("Hours", selection: $selectedhours){
                        ForEach(0..<24){ i in
                            Text("\(i)h")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    
                    Picker("Minutes", selection: $selectedminutes){
                        ForEach(0..<60){ i in
                            Text("\(i)m")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    
                    Picker("Hours", selection: $selectedseconds){
                        ForEach(0..<60){ i in
                            Text("\(i)s")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
                .padding()
                
                HStack{
                    Button(action: {
                        showpicker=true
                        timerrunning=false
                    }, label: {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 90, height: 90)
                            .font(.title2)
                            .overlay(
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                            )
                    })
                    .padding()
                    
                    
                    Spacer()
                    
                    Button(action: {
                        remainingtime=TimeInterval(selectedhours*60*60+selectedminutes*60+selectedseconds)
                        showpicker=false
                        timerrunning=true
                    }, label: {
                        Circle()
                            .frame(width: 90, height: 90)
                            .foregroundColor(.green)
                            .overlay(
                                Text("Start")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                            )
                    })
                    .padding()
                }
            }
            else{
                
                ProgressView(value: caculateprogress())
                Text(timeString(time:remainingtime))
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom,25)
                
                HStack{
                    Button(action: {
                        timerrunning=false
                        showpicker=true
                    }, label: {
                        Circle()
                            .frame(width: 90, height: 90)
                            .foregroundColor(.gray)
                            .overlay(
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                            )
                    })
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        timerrunning.toggle()
                    }, label: {
                        Circle()
                            .frame(width: 90, height: 90)
                            .foregroundColor(timerrunning ? .green : .red)
                            .overlay(
                                Text(timerrunning ? "Pause" : "Resume")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .bold()
                            )
                    })
                }
                
            }
        }
        .preferredColorScheme(.dark)
        .onReceive(timer){ _ in
            if timerrunning{
                remainingtime-=1
                if remainingtime==0{
                    timerrunning=false
                    showpicker=true
                }
            }
        }
    }
    func timeString(time:TimeInterval)->String{
        let hours = Int(time)/3600
        let minutes = Int(time)/60%60
        let seconds = Int(time)%60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
   func caculateprogress()->Double{
                  let progress=1-remainingtime/Double(selectedhours*3600+selectedminutes*60+selectedseconds)
                    
                    return progress
                }
}

#Preview {
    Timerview()
}
