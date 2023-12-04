//
//  ListItemView.swift
//  RBChallenge
//
//  Created by George Stratulat on 04.12.2023.
//

import SwiftUI

struct ListItemView: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                image
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
            } placeholder: {
                ZStack {
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(height: 40)
                    Text(user.name.first.prefix(1))
                        .font(.title)
                }
            }

            VStack(alignment: .leading) {
                Text(user.name.first + " " + user.name.last)
                    .font(.title3)
                Text(user.email)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack {
                Text("12:50")
                    .foregroundColor(.gray)
                Image(systemName: "star")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(user: User(name: Name(title: "Mr", first: "George", last: "Stratulat"), email: "email@email.com", id: ID(name: "name", value: "value"), picture: Picture(large: "https://i.pinimg.com/736x/d4/73/f3/d473f390ed78cc845580d8f4911cac3a.jpg", medium: "https://i.pinimg.com/736x/d4/73/f3/d473f390ed78cc845580d8f4911cac3a.jpg", thumbnail: "https://i.pinimg.com/736x/d4/73/f3/d473f390ed78cc845580d8f4911cac3a.jpg")))
    }
}
