//
//  FavoritesModel.swift
//  Goods
//
//  Created by Данила on 27.08.2023.
//

import Foundation


class RequestFavorites {
    func request(array: Array<Int>, completion: @escaping ([Advertisement?]) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let goodsResponse = try JSONDecoder().decode(Welcome.self, from: data)
                let filteredAdvertisements = goodsResponse.advertisements.filter { advertisement in
                    return array.contains(Int(advertisement.id)!-1)
                }
                completion(filteredAdvertisements)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
