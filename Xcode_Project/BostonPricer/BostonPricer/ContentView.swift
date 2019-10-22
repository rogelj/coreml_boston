//
//  ContentView.swift
//  BostonPricer
//
//  Created by Jesus Rogel on 09/10/2019.
//  Copyright © 2019 Jesus Rogel. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let crimeData = Array(stride(from: 0.05, through: 3.7, by: 0.1))
    let roomData = Array(4...9)

    @State var popUpVisible: Bool = false
    @State var pickerCrime = 0
    @State var pickerRoom = 0

    var body: some View {
        NavigationView {
            VStack {
                Text("Boston Pricer")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)

                VStack {
                    Picker(selection: $pickerCrime, label: Text("Crime")) {
                        ForEach(0..<crimeData.count) { ix in
                            Text("\(self.crimeData[ix], specifier: "%.2f")").tag(ix)
                        }
                    }
                    .padding(.leading, 10)
                    Picker(selection: $pickerRoom, label: Text("No. Rooms")) {
                        ForEach(0..<roomData.count) { ix in
                            Text("\(self.roomData[ix])").tag(ix)
                        }
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
                        message: Text("The values picked are\n Crime Rate: \(crimeData[pickerCrime])\n Rooms: \(roomData[pickerRoom])"),
                        dismissButton: .default(Text("Cool!")))
                }.padding()

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
