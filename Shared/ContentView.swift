//
//  ContentView.swift
//  Shared
//
//  Created by Luke Drushell on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.white.opacity(1.0))
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            TabView {
               ListView()
                    .tabItem({
                        Label("List", systemImage: "list.bullet.rectangle.portrait")
                    })
                PillsView()
                     .tabItem({
                         Label("Pills", systemImage: "capsule.portrait")
                     })
                CardsView()
                     .tabItem({
                         Label("Cards", systemImage: "rectangle.grid.1x2")
                     })
                ButtonsView()
                     .tabItem({
                         Label("Buttons", systemImage: "square.inset.filled")
                     })
                
                
            } .accentColor(.teal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct PillsView: View {
    var body: some View {
        ZStack {
            Color.red
        } .edgesIgnoringSafeArea(.all)
    }
}

struct ButtonsView: View {
    
    
    @State private var paused = true
    @State private var light = true
    @State private var back = true
    @State private var shrinked = false
    @State private var shrinked2 = false
    
    var body: some View {
        TabView {
            ZStack {
                Color.pink
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Button {
                        
                    } label: {
                        Text("Click me!")
                            .foregroundColor(.blue)
                            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.05, alignment: .center)
                            .padding()
                            .background(.white)
                            .cornerRadius(15)
                    } .padding()
                    
                    Button {
                        
                    } label: {
                        Text("Click me!")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.05, alignment: .center)
                            .padding()
                            .background(.blue)
                            .cornerRadius(15)
                    } .padding()
                }
            }
            ZStack {
                Color.green
                    .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Button {
                        light.toggle()
                    } label: {
                        Image(systemName: light ? "moon.circle" : "sun.max.circle")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                    
                    Button {
                        paused.toggle()
                    } label: {
                        Image(systemName: paused ? "play.circle" : "pause.circle")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                    .padding()
                    
                    Button {
                        back.toggle()
                    } label: {
                        Image(systemName: back ? "backward.circle" : "forward.circle")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.width*0.2, alignment: .center)
                .background(Color.white)
                .cornerRadius(25)
            }
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Button {
                        shrinked = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                            shrinked = false
                        })
                    } label: {
                        Text("Click me!")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.05, alignment: .center)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.pink, .purple, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                            .cornerRadius(17)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 3)
                            )
                            .scaleEffect(shrinked ? 0.95 : 1.0)
                    } .padding()
                    
                    Button {
                        shrinked2 = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                            shrinked2 = false
                        })
                    } label: {
                        Text("Click me!")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.05, alignment: .center)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                            .overlay(Color.white.opacity(0.2).blur(radius: 10))
                            .cornerRadius(15)
                            .scaleEffect(shrinked2 ? 0.95 : 1.0)
                    } .padding()
                }
                
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .tabViewStyle(.page)
    }
}

struct ListView: View {
    
    fileprivate func randomCircle() -> some View {
        return Circle()
            .foregroundColor(Color.blue)
            .frame(width: 300, height: 300, alignment: .center)
            .blur(radius: CGFloat(Int.random(in: 20...35)))
            .opacity(Double.random(in: 0.2...0.5))
            .position(x: Double.random(in: 0...UIScreen.main.bounds.width), y: Double.random(in: 0...UIScreen.main.bounds.height))
    }
    
    @State var refreshing = false
    @State var textNum = Int.random(in: 0...1)
    
    var body: some View {
        ZStack {
            if refreshing != true {
                NavigationView {
                    ZStack {
                        ForEach(0...5, id: \.self) { index in
                            randomCircle()
                        }
                        List {
                            ForEach(0...25, id: \.self) { index in
                                HStack {
                                    Button {
                                        
                                    } label: {
                                        Capsule()
                                            .foregroundColor(.white)
                                            .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.1, alignment: .center)
                                            .overlay(
                                                Text(textNum == 0 ? "Test" : "Item")
                                            )
                                    }
                                } .listRowBackground(Color.white.opacity(0.1))
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .background(Color.clear)
                    }.refreshable {
                        refreshing.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            textNum = Int.random(in: 0...1)
                            refreshing.toggle()
                        })
                    } .background(Color.green)
                }
            } else {
                Text("Refreshing")
            }
        } .edgesIgnoringSafeArea(.all)
    }
}

struct CardsView: View {
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            Color.blue
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0...14, id: \.self) { index in
                        
                        Button {
                            
                        } label: {
                            VStack {
                                HStack {
                                    Image(systemName: "house.fill")
                                        .resizable()
                                        .frame(width: 40, height: 35, alignment: .center)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("Toggle Home")
                                        .font(.system(size: 17, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                .padding(.top, 15)
                                .padding(.leading, 18)
                                .padding(.trailing, 18)
                                
                                Text("Tap to toggle all devices in the house")
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                                    .foregroundColor(.white.opacity(0.75))
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(width: 150, height: 150, alignment: .center)
                            .preferredColorScheme(.dark)
                            .background(.regularMaterial)
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(.top, 100)
                .padding(.bottom, 100)
            }
            .padding(10)
        }
    }
}



