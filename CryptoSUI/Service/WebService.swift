//
//  WebService.swift
//  CryptoSUI
//
//  Created by Hatice Taşdemir on 7.11.2024.
//

import Foundation

class WebService {
    
   /* //async ile daha kısa download func yazma:
    func downloadCurrenciesAsync(url: URL) async throws ->  [CryptoCurrency]? {
        //data async func datatask yerine kullanılabilir. do trycatchde yapılır
        let (data, response) = try await URLSession.shared.data(from: url)
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        return currencies
    }*/
    
    func downloadCurrenciesContinuation(url : URL) async throws -> [CryptoCurrency] {
            //this will allow to resume from the suspended state and conform to be async 
            try await withCheckedThrowingContinuation { continuation in
                downloadCurrencies(url: url) { result in
                    switch result {
                    case .success(let cryptos):
                        continuation.resume(returning: cryptos ?? [])
                        
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    
    //bu func bir url alacak, completion bloğunda escaping yani iş bittiğinde geri döndüreceği şeyleri verecek.
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?,DownloaderError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //optional old için if let yaptım.
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            //guard let bu satırı doğru kabul ediyor. yani data var hata yok ama else kısımı hata var data yok demek
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
    }.resume()
        
    }
        
    }
    
    //debug için hatayı kendimiz yazmamız daha yönetilebilir kılar.
    enum DownloaderError :  Error {
        case badUrl
        case noData
        case dataParseError
    }

