//
//  ContentView.swift
//  WorldTime
//
//  Created by yonas on 27/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isNew = true
    var body: some View {
        VStack {
        
        }
        .fullScreenCover(isPresented: $isNew) {
            Loading()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
