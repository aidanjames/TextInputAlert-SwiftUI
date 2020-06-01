//
//  ContentView.swift
//  TextInputAlert-SwiftUI
//
//  Created by Aidan Pendlebury on 12/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var myValue = ""
    @State private var showingCustomAlert = false
    @State private var showingNormalAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 40) {
                    Button(action: { self.showingCustomAlert.toggle() } ) {
                        Text("Show custom alert")
                    }
                    Button(action: { self.showingNormalAlert.toggle() } ) {
                        Text("Show normal alert")
                    }
                    .alert(isPresented: $showingNormalAlert) {
                        Alert(title: Text("Add player"), message: Text("Select 'Show custom alert' to add a player."), dismissButton: .cancel())
                    }
                    Button("Clear title") { self.myValue = "" }.foregroundColor(.red)
                }
                if showingCustomAlert {
                    TextInputAlertView(showingModal: self.$showingCustomAlert, titleText: "Add player", placeholderText: "Enter a name", bodyText: "Add a name for your player.") { value in
                        self.myValue = value
                    }
                }
            }
            .navigationBarTitle("\(myValue.isEmpty ? "This will change" : myValue)")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
