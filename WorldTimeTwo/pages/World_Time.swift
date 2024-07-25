import Foundation

class WorldTime {
    private var location: String = ""
    private var flag: String = ""
    private var url: String = ""
    private var currentTime: String = ""
    
    init(location: String, flag: String, url: String) {
        self.location = location
        self.flag = flag
        self.url = url
    }
    
    public func returnTime() -> String {
        return self.currentTime
    }
    
    public func getFlag() -> String{
        return self.flag
    }
    
    public func getCountry() -> String{
        return self.location
    }
    
    public func fetchTimeData(completion: @escaping () -> Void) {
        fetchTime(completion: completion)
    }
    
    private func fetchTime(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://worldtimeapi.org/api/timezone/\(self.url)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let timeData = try decoder.decode(WorldTimeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.currentTime = self.formatToLocalTime(timeData.utc_datetime, timeData.timezone)
                        completion() // Call the completion handler when the data is fetched
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }

    private func formatToLocalTime(_ utcDatetime: String, _ timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Adjust the format based on your API response
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = dateFormatter.date(from: utcDatetime) {
            dateFormatter.timeZone = TimeZone(identifier: timezone) // Set to the specific timezone
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}

struct WorldTimeResponse: Codable {
    let utc_datetime: String
    let timezone: String
    // Add other properties you want to decode from the API response
}
