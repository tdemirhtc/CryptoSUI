//
//  CryptoCurrency.swift
//  CryptoSUI
//
//  Created by Hatice Taşdemir on 7.11.2024.
//

import Foundation
struct CryptoCurrency : Decodable, Identifiable {
    
    let currency : String
    let price : String
    let id = UUID()
    
    //protocol bir arayüz. oluşturulan caselerle hangi değişken için hangi şekilde hangi isimde geleceğini  belirtebildiğimiz bir yapı. bu caseler dışında case gelmeyecek id gemeyecek dolayısıyla koymadığım için bu 2 case decode ederken id oto. struct içerisinde atayacak. 
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
    
}
