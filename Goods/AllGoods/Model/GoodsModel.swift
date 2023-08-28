//
//  GoodsModel.swift
//  Goods
//
//  Created by Данила on 24.08.2023.
//

import Foundation


class Request {
    func request(completion: @escaping ([Advertisement?]) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let goodsResponse = try JSONDecoder().decode(Welcome.self, from: data)
                completion(goodsResponse.advertisements)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
