//
//  NetworkManager.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 10/07/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private var API_EndPoint : String = "https://api.stackexchange.com/2.3/search/excerpts?order=desc&sort=activity&q=%@&site=stackoverflow&filter=!7gW2J7WMYMMzBpsH--2Wd4yV2b5CtT6XM-"
    
    func fetchQuestions(Title : String, taskCompleted: @escaping ([QuestionModel], Bool) -> Void) -> Void{
        let FixedString = Helper.shared.FixStringToAllowedInRequest(NonAllowedString: Title)
        let Formatted_EndPoint = String(format: API_EndPoint, FixedString)
        let url : URL = URL(string: Formatted_EndPoint)!
        var HttpRequest = URLRequest(url: url)
        HttpRequest.httpMethod = "GET"
        HttpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let Httptask = URLSession.shared.dataTask(with: HttpRequest) { data, response, error in
            if let _ = error  {
                // we don't need to use guard, we will not use error in this fucntion again, we just check if there are an error or not..
                taskCompleted([], false)
                return
            }
            // check if response is nil and casting to HTTPURLResponse to check http error code is not equals to OK ( 200 )
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                taskCompleted([], false)
                return
            }
            guard let data = data else { // check if data is not nil ..
                taskCompleted([], false)
                return
            }
            do {
                let JsonDecoder = JSONDecoder()
                let Decoded_Json = try JsonDecoder.decode(ResponseModel.self, from: data)
                taskCompleted(Decoded_Json.items, true)
            } catch {
                taskCompleted([], false)
            }
        }
        Httptask.resume()
    }
}
