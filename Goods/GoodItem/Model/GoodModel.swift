//
//  GoodModel.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation

class RequestGood {
    func request(id: String, completion: @escaping (WelcomeGood?) -> Void) {
        print("request")
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            print(data)
            guard let data = data else { return }
            do {
                let goodResponse = try JSONDecoder().decode(WelcomeGood.self, from: data)
                completion(goodResponse)
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
}
