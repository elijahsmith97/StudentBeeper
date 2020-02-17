//
//  ContentDetail.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/11/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import SwiftUI

struct ContentDetail: View {
    
    var name:String
    
    var body: some View {
        HStack {
            Image(name)
                .resizable().frame(width: 60, height: 60)
                .clipShape(Circle())
            Text("Beeper: \(name)")
        }
    }
}

struct ContentDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetail(name: "Elijah")
    }
}
