//
//  ContentRow.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/11/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import SwiftUI

struct ContentRow: View {
    
    var name:String
    
    var body: some View {
        HStack {
            Image("elijah").resizable().frame(width: 60, height: 60)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Beeper: \(name)")
                    .font(.title)
                Text("OG Dev")
            }
            Spacer()
        }.padding()
    }
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(name: "Elijah")
    }
}
