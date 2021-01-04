//
//  ContentView.swift
//  LearnAlignment
//
//  Created by Girish Adiga on 1/3/21.
//

// code learnings from : https://swiftui-lab.com/alignment-guides/
// and https://www.donnywals.com/what-is-escaping-in-swift/

import SwiftUI

struct ContentView: View {
    @State var position: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Hello()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.green).opacity(0.5))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { d in self.helloH(d) })
                    .alignmentGuide(VerticalAlignment.center, computeValue: { d in self.helloV(d) })
                
                World()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow).opacity(0.5))
                    //.alignmentGuide(HorizontalAlignment.center, computeValue: { d in self.worldH(d) })
                  //  .alignmentGuide(VerticalAlignment.center, computeValue: { d in self.worldV(d) })
                
            }

            Spacer()
            
            HStack {
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.position = 0 } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("H W").foregroundColor(.black))
                })

                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.position = 1 } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("H\nW").foregroundColor(.black))
                })
                
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.position = 2 } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("W H").foregroundColor(.black))
                })

                Button(action: { withAnimation(.easeInOut(duration: 1.0)) { self.position = 3
                         } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("W\nH").foregroundColor(.black))
                })
                
                Button(action: { withAnimation(.easeInOut(duration: 1.0)) {
                    
                    
        makeRequest( {result in
            switch result {
                
            case .success((_, _)):
                do {
                    let (data,res) = try result.get()
                    print("something ", data,res)
                } catch {
                    print("got error")
                }
            case .failure(_):
                print("failure")
            }
                        
                    })
                    
                    
                    
                } }, label: {
                    Rectangle().frame(width: 50, height: 50).overlay(Text("data").foregroundColor(.black))
                })
            }

        }
    }
    
    func helloH(_ d: ViewDimensions) -> CGFloat {
        if position == 0 {
            return 0
        } else if position == 1 {
            return 0
        } else if position == 2 {
            return d[.leading] - 10
        } else {
            return 0
        }
    }

    func helloV(_ d: ViewDimensions) -> CGFloat {
        if position == 0 {
            return 0
        } else if position == 1 {
            return d[.bottom] + 10
        } else if position == 2 {
            return 0
        } else {
            return d[.top] - 10
        }
    }

    func worldH(_ d: ViewDimensions) -> CGFloat {
        if position == 0 {
            return 0
        } else if position == 1 {
            return 0
        } else if position == 2 {
            return d[.trailing] + 10
        } else {
            return 0
        }
    }

    func worldV(_ d: ViewDimensions) -> CGFloat {
        if position == 0 {
            return 0
        } else if position == 1 {
            return d[.top] - 10
        } else if position == 2 {
            return 0
        } else {
            return d[.bottom] + 10
        }
    }

}


func makeRequest(_ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
  URLSession.shared.dataTask(with: URL(string: "https://donnywals.com")!) { data, response, error in
    if let error = error {
      completion(.failure(error))
    } else if let data = data, let response = response {
      completion(.success((data, response)))
    }

   // assertionFailure("We should either have an error or data + response.")
  }.resume()
}

struct Hello: View {
    var body: some View {
        Group { Text("Hello").foregroundColor(.black) + Text(" World").foregroundColor(.clear) }.padding(20)
    }
}

struct World: View {
    var body: some View {
        Group { Text("Hello").foregroundColor(.clear) + Text(" World").foregroundColor(.black) }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
