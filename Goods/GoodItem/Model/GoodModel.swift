//
//  GoodModel.swift
//  Goods
//
//  Created by Данила on 25.08.2023.
//

import Foundation

class RequestGood {
    func request(id: String, completion: @escaping (WelcomeGood?) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion(nil)
                return }
            do {
                let goodResponse = try JSONDecoder().decode(WelcomeGood.self, from: data)
                completion(goodResponse)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
