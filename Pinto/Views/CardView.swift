//
//  CardView.swift
//  Pinto
//
//  Created by Cesar on 15/11/21.
//

import SwiftUI

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.default, size: CGSize(width: 100, height: 100))
    }
}


struct CardView: View {
    var card: Card
    var size: CGSize
    var includeShadow: Bool = true
    var body: some View {
        
        if(card.isFaceUp){
            if(includeShadow){
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                    .shadow(radius: 8)
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
            }else {
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.3))
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
            }
        }else {
            Image("facedown")
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                .clipped(antialiased: true)
                .contentShape(Rectangle())
            
        }
        
    }
}
