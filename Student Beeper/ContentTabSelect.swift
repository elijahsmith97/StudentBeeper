//
//  ContentTabSelect.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/11/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import SwiftUI

struct ContentTabSelect: View {
    var body: some View {
        List(beepers){ beeper in
           
            
            NavigationLink(destination: ContentDetail(name: beeper.name)){
                ContentRow(name: beeper.name)
            }
        }
    }
}

struct ContentTabSelect_Previews: PreviewProvider {
    static var previews: some View {
        ContentTabSelect()
    }
}
