//
//  Addalarmview.swift
//  clockapp
//
//  Created by Karan Singla on 03/02/24.
//

import SwiftUI

struct AddAlarmView: View {
    @Binding var alarms: [Alarm]
    @State private var date = Date()
    @State private var label = ""
    
    @Environment(\.dismiss)var dismiss

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select time", selection: $date, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                
                GroupBox{
                    TextField("Label",text:$label)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
                
            }
            .padding(.top,50)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        alarms.append(Alarm(time:date, label: label, ison: true))
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(.title3)
                            .foregroundColor(.orange)
                            .bold()
                    })
                }
            }
            
        }
    }
}

struct Addalarmview: PreviewProvider {
    static var previews: some View {
        let alarms: [Alarm] = []
        AddAlarmView(alarms: .constant(alarms))
    }
}
