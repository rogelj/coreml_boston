//
//  ContentView.swift
//  BostonPricer
//
//  Created by Jesus Rogel on 09/10/2019.
//  Copyright © 2019 Jesus Rogel. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let crimeData = Array(stride(from: 0.05, through: 3.65, by: 0.1))
    let roomData = Array(4...9)

    @State var popUpVisible: Bool = false
    @State var pickerCrime = 0.05
    @State var pickerRoom = 4

    var body: some View {
        NavigationView {
            VStack {
                Text("Boston Pricer")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)

                VStack {
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Crime")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                    .padding(.leading, 10)
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("No. Rooms")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                    .padding(.leading, 10)
                }

                Button(action: {
                    self.popUpVisible = true
                }) {
                    Text("Get Prediction")
                }
                .alert(isPresented: self.$popUpVisible) {
                    Alert(title: Text("Prediction"),
                        message: Text("Prediction will be shown here."),
                        dismissButton: .default(Text("Cool!")))
                }

                Spacer()
            }
        }
    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
