//
//  Location.swift
//  WorldTime
//
//  Created by yonas on 27/02/2024.
//

import SwiftUI

struct LocationData {
    let locationX: String
    let flagX: String
    let urlX: String
}

struct Location: View {
    @State private var currentImageIndex: Int = 0
    @State private var isAnimating: Bool = true
    @State var images = ["progressOne", "progressTwo", "progressThree", "progressFour", "progressFive"]
    @State var count: Int = 0
    @State var isNew = false
    @State private var flag: String = ""
    @State private var country: String = ""
    @State private var time: String = ""
    @State private var main = false
    
    let locations: [LocationData] = [
            LocationData(locationX: "Abidjan", flagX: "cotdivoire", urlX: "Africa/Abidjan"),
            LocationData(locationX: "Addis Ababa", flagX: "ethiopia", urlX: "Africa/Addis_Ababa"),
            LocationData(locationX: "Algiers", flagX: "algeria", urlX: "Africa/Algiers"),
            LocationData(locationX: "Anchorage", flagX: "usa", urlX: "America/Anchorage"),
            LocationData(locationX: "Araguaina", flagX: "brazil", urlX: "America/Araguaina"),
            LocationData(locationX: "Asuncion", flagX: "paraguay", urlX: "America/Asuncion"),
            LocationData(locationX: "Bahia", flagX: "brazil", urlX: "America/Bahia"),
            LocationData(locationX: "Bahia_Banderas", flagX: "mexico", urlX: "America/Bahia_Banderas"),
            LocationData(locationX: "Barbados", flagX: "barbados", urlX: "America/Barbados"),
            LocationData(locationX: "Belem", flagX: "brazil", urlX: "America/Belem"),
            LocationData(locationX: "Belize", flagX: "brazil", urlX: "America/Belize"),
            LocationData(locationX: "Boa_Vista", flagX: "brazil", urlX: "America/Boa_Vista"),
            LocationData(locationX: "Bogota", flagX: "colombi", urlX: "America/Bogota"),
            LocationData(locationX: "Boise", flagX: "usa", urlX: "America/Boise"),
            LocationData(locationX: "Buenos_Aires", flagX: "argentina", urlX: "America/Araguaina"),
            LocationData(locationX: "Cairo", flagX: "egypt", urlX: "Africa/Cairo"),
            LocationData(locationX: "Cambridge_Bay", flagX: "canada", urlX: "America/Cambridge_Bay"),
            LocationData(locationX: "Cambridge_Bay", flagX: "canada", urlX: "America/Cambridge_Bay"),
            LocationData(locationX: "Campo_Grande", flagX: "belize", urlX: "America/Campo_Grande"),
            LocationData(locationX: "Cancun", flagX: "mexico", urlX: "America/Cancun"),
            LocationData(locationX: "Caracas", flagX: "venezuela", urlX: "America/Caracas"),
            LocationData(locationX: "Casablanca", flagX: "moroco", urlX: "Africa/Casablanca"),
            LocationData(locationX: "Catamarca", flagX: "argentina", urlX: "America/Argentina/Catamarca"),
            LocationData(locationX: "Ceuta", flagX: "spain", urlX: "Africa/Ceuta"),
            LocationData(locationX: "Chicago", flagX: "usa", urlX: "America/Chicago"),
            LocationData(locationX: "Chicago", flagX: "usa", urlX: "America/Chicago"),
            LocationData(locationX: "Chihuahua", flagX: "mexico", urlX: "America/Chihuahua"),
            LocationData(locationX: "Ciudad_Juarez", flagX: "mexico", urlX: "America/Ciudad_Juarez"),
            LocationData(locationX: "Cuiaba", flagX: "belize", urlX: "America/Cuiaba"),
            LocationData(locationX: "Danmarkshavn", flagX: "denmark", urlX: "America/Danmarkshavn"),
            LocationData(locationX: "Dawson", flagX: "usa", urlX: "America/Dawson"),
            LocationData(locationX: "Dawson_Creek", flagX: "usa", urlX: "America/Dawson_Creek"),
            LocationData(locationX: "Dili", flagX: "india", urlX: "Asia/Dili"),
            LocationData(locationX: "Dubai", flagX: "uae", urlX: "Asia/Dubai"),
            LocationData(locationX: "El_Aaiun", flagX: "moroco", urlX: "Africa/El_Aaiun"),
            LocationData(locationX: "Hong-Kong", flagX: "china", urlX: "Asia/Hong_Kong"),
            LocationData(locationX: "Johannesburg", flagX: "southAfrica", urlX: "Africa/Johannesburg"),
            LocationData(locationX: "Juba", flagX: "southSudan", urlX: "Africa/Juba"),
            LocationData(locationX: "Jujuy", flagX: "argentina", urlX: "America/Argentina/Jujuy"),
            LocationData(locationX: "Khartoum", flagX: "sudan", urlX: "Africa/Khartoum"),
            LocationData(locationX: "Lagos", flagX: "nigeria", urlX: "Africa/Lagos"),
            LocationData(locationX: "La_Rioja", flagX: "argentina", urlX: "America/Argentina/La_Rioja"),
            LocationData(locationX: "London", flagX: "London", urlX: "Europe/London"),
            LocationData(locationX: "Maputo", flagX: "mozambique", urlX: "Africa/Maputo"),
            LocationData(locationX: "Mendoza", flagX: "argentina", urlX: "America/Argentina/Mendoza"),
            LocationData(locationX: "Monrovia", flagX: "libiya", urlX: "Africa/Monrovia"),
            LocationData(locationX: "Moscow", flagX: "russia", urlX: "Europe/Moscow"),
            LocationData(locationX: "Nairobi", flagX: "kenya", urlX: "Africa/Nairobi"),
            LocationData(locationX: "Ndjamena", flagX: "chad", urlX: "Africa/Ndjamena"),
            LocationData(locationX: "Pyongyang", flagX: "dprk", urlX: "Asia/Pyongyang"),
            LocationData(locationX: "Rio_Gallegos", flagX: "argentina", urlX: "America/Argentina/Rio_Gallegos"),
            LocationData(locationX: "Salta", flagX: "argentina", urlX: "America/Argentina/Salta"),
            LocationData(locationX: "San_Juan", flagX: "argentina", urlX: "America/Argentina/Salta"),
            LocationData(locationX: "San_Luis", flagX: "argentina", urlX: "America/Argentina/San_Luis"),
            LocationData(locationX: "Sao_Paulo", flagX: "brazil", urlX: "America/Sao_Paulo"),
            LocationData(locationX: "Sao_Tome", flagX: "saoTome", urlX: "Africa/Sao_Tome"),
            LocationData(locationX: "Seoul", flagX: "south_korea", urlX: "Asia/Seoul"),
            LocationData(locationX: "Sydney", flagX: "australia", urlX: "Australia/Sydney"),
            LocationData(locationX: "Tripoli", flagX: "libiya", urlX: "Africa/Tripoli"),
            LocationData(locationX: "Tucuman", flagX: "argentina", urlX: "America/Argentina/Tucuman"),
            LocationData(locationX: "Ushuaia", flagX: "argentina", urlX: "America/Argentina/Ushuaia"),
            LocationData(locationX: "Windhoek", flagX: "namibiya", urlX: "Africa/Windhoek"),
            
            //
        ]

    
    var body: some View {
        VStack{
            HStack{
                
                Button {
                    main.toggle()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .font(.system(size:26))
                }
                Spacer()

                
                Text("Choose a Location")
                    .foregroundColor(Color.white)
                    .font(.system(size:26))
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.blue)
            ScrollView{
                VStack{
                    ForEach(locations, id: \.locationX) { location in
                        Button{
                            startTimer(locationX: location.locationX, flagX: location.flagX, urlX: location.urlX)
                        } label: {
                            HStack {
                                Image(location.flagX).renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                Text(location.locationX)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.black)
                                Spacer()
                            }
                            .padding(.all, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .fullScreenCover(isPresented: $isNew) {
                                Home(flag: $flag, country: $country, time: $time)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal,10)
            .background(Color("darkBackground"))
            .fullScreenCover(isPresented: $main) {
                Loading()
            }
//            .safeAreaInset(edge: .top, spacing: nil) {
//                HStack{
//                    Text("")
//                    
//                }
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//            }
        }
        
    }
    
    private func startTimer(locationX: String, flagX: String, urlX: String) {
        let x = WorldTime(location: locationX, flag: flagX, url: urlX)
        x.fetchTimeData {
            let y = x.returnTime()
            flag = x.getFlag()
            country = x.getCountry()
            time = y
            print("Current time: \(y)") // Use the updated time here

            // Start timer after fetching time data
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                withAnimation {
                    if isAnimating {
                        currentImageIndex = (currentImageIndex + 1) % images.count
                        count += 1
                        if (count == 5) {
                            isNew.toggle()
                        }
                    } else {
                        timer.invalidate()
                    }
                }
            }
        }
    }
}

struct Location_Previews: PreviewProvider {
    static var previews: some View {
        Location()
    }
}
