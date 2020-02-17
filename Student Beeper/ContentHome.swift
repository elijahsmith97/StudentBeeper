//
//  ContentHome.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/4/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import SwiftUI

struct ContentHome: View {
    var body: some View {
        HStack {
            Image("wheel3").resizable().frame(width: 75, height: 60)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Student Beeper")
                .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Boone")
                .foregroundColor(Color.blue)
                
            }
            Spacer()
        }.padding()
    }
}

struct ContentHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentHome()
    }
}
