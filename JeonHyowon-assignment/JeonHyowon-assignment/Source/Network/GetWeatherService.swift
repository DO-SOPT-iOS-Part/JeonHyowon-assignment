//
//  GetWeatherService.swift
//  JeonHyowon-assignment
//
//  Created by Hyowon Jeon on 11/17/23.
//

import Foundation

class GetWeatherService {
    static let shared = GetWeatherService()
    private init() {}
    
    func makeRequest(cityName: String) -> URLRequest {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&lang=kr&appid=e98dd4e8f587a33d9731eb6b0fc9ff31")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func getWeatherData(cityName: String) async throws -> WeatherData? {
        do {
            let request = self.makeRequest(cityName: cityName)
            let (data, response) = try await URLSession.shared.data(for: request)
            dump(request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            dump(response)
            return parseWeatherData(data: data)
        } catch {
            throw error
        }
    }
    
    private func parseWeatherData(data: Data) -> WeatherData? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(WeatherData.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
}
