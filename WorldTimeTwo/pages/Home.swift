import SwiftUI

struct Home: View {
    @State var isDayTime: Bool = true
    @State var isNew: Bool = false
    @Binding var flag: String
    @Binding var country: String
    @Binding var time: String
    @State var forColor: Color = .orange

    var body: some View {
        preview
            .onAppear {
                convertTime()
                forColor = loadColor()
            }
    }

    func convertTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "HH"
            dateFormatter.timeZone = TimeZone.current
            let hour = Int(dateFormatter.string(from: date)) ?? 12
            
            isDayTime = hour > 6 && hour < 18
        }
    }

    func saveColor(color: Color) {
        let uiColor = UIColor(color)
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: "selectedColor")
        }
    }

    func loadColor() -> Color {
        if let colorData = UserDefaults.standard.data(forKey: "selectedColor"),
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            return Color(uiColor)
        }
        return .orange  // Default color if no color is saved
    }
}

extension Home {
    var preview: some View {
        VStack {
            HStack {
                Menu {
                    VStack {
                        Button {
                            forColor = .orange
                            saveColor(color: forColor)
                        } label: {
                            Text("Orange")
                                .foregroundColor(.orange)
                        }
                        Button {
                            forColor = .green
                            saveColor(color: forColor)
                        } label: {
                            Text("Green")
                                .foregroundColor(.green)
                        }
                        Button {
                            forColor = .cyan
                            saveColor(color: forColor)
                        } label: {
                            Text("Cyan")
                                .foregroundColor(.cyan)
                        }
                        Button {
                            forColor = .pink
                            saveColor(color: forColor)
                        } label: {
                            Text("Pink")
                                .foregroundColor(.pink)
                        }
                    }
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 26))
                }
                Spacer()
                Text("World Time")
                    .font(.system(size: 26))
                Spacer()
            }
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .background(isDayTime ? Color("skyBlue") : Color("lightDark"))

            VStack {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 20)
                    .foregroundColor(Color("blue"))
                Button {
                    isNew.toggle()
                } label: {
                    HStack {
                        Image("editLocation")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 10)
                        Text("Select Location")
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    .background(forColor)
                    .cornerRadius(10)
                    .fullScreenCover(isPresented: $isNew) {
                        Location()
                    }
                }
                
                Image(flag)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 120)
                    .padding(.top, 10)
                
                Text(country)
                    .font(.custom("Monoton-Regular", size: 35))
                    .foregroundColor(forColor)
                    .padding(.bottom, 5)
                Text(time)
                    .foregroundColor(forColor)
                    .font(.system(size: 60))
                
                Spacer()
            }
            .padding(0)
            .background(
                Image(isDayTime ? "day" : "night")
                    .resizable()
                    .scaledToFill()
            )
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


