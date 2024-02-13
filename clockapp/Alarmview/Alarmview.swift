//
//  Alarmview.swift
//  clockapp
//
//  Created by Karan Singla on 02/02/24.
//

import SwiftUI


struct Alarmview: View {
    @State private var alarms:[Alarm]=[]
    
    
    @State private var showalarmview=false
    var body: some View {
        NavigationView{
            List{
                ForEach(alarms){alarm in
                    HStack{
                        VStack(alignment: .leading){
                            Text(alarm.time, style: .time)
                                .font(.largeTitle)
                                .foregroundColor(alarm.ison ? .white: .gray)
                            Text(alarm.label)
                                .foregroundColor(alarm.ison ? .white: .gray)
                        }
                        Spacer()
                        
                        Toggle("", isOn: Binding<Bool>(
                            get: {
                                alarm.ison
                            }, set: { newValue in
                                if let index = alarms.firstIndex(of: alarm) {
                                    alarms[index].ison = newValue
                                }
                            }
                        ))
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            if let index = alarms.firstIndex(of: alarm) {
                                alarms.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    .contextMenu{
                        Button {
                            if let index = alarms.firstIndex(of: alarm) {
                                alarms[index].ison.toggle()
                            }
                        } label: {
                            Label(alarm.ison ? "Turn Off" : "Turn On", systemImage: alarm.ison ? "bell.lash.fill" : "bell.fill")
                        }
                        
                        Button {
                            if let index = alarms.firstIndex(of: alarm) {
                                alarms.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Alarms")
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showalarmview.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)
                    }

                }
            }
            .sheet(isPresented: $showalarmview, content: {
                AddAlarmView(alarms: $alarms)
            })
        }
    }
}

struct Alarm:Identifiable,Equatable{
    var id=UUID()
    var time:Date
    var label=""
    var ison:Bool
}
#Preview {
    Alarmview()
}
