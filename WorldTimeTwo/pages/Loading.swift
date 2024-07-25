import SwiftUI

struct Loading: View {
    @State private var currentImageIndex: Int = 0
    @State private var isAnimating: Bool = true
    @State var images = ["progressOne", "progressTwo", "progressThree", "progressFour", "progressFive"]
    @State var count: Int = 0
    @State var isNew = false
    @State private var flag: String = ""
    @State private var country: String = ""
    @State private var time: String = ""
    var body: some View {
        VStack {
           
            VStack{
                Image(images[currentImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color("blueDark"))
        .onAppear {
            startTimer()
        }
        .fullScreenCover(isPresented: $isNew) {
            Home(flag: $flag, country: $country, time: $time)
        }
    }

    private func startTimer() {
        let x = WorldTime(location: "Addis Ababa", flag: "ethiopia", url: "Africa/Addis_Ababa")
        x.fetchTimeData {
            let y = x.returnTime()
            flag = x.getFlag()
            country = x.getCountry()
            time = y
            print("Current time: \(y)") // Use the updated time here
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            withAnimation {
                if isAnimating {
                    currentImageIndex = (currentImageIndex + 1) % images.count
                    count += 1
                    if (count == 5){
                        isNew.toggle()
                    }
                } else {
                    timer.invalidate()
                }
            }
        }
    }

    
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
