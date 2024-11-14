//
//  ContentView.swift
//  CryptoSUI
//
//  Created by Hatice Taşdemir on 7.11.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
        }
    
    var body: some View {
        //verileri çekmek
        NavigationView {
            //idler uuıd old için belirtilmesi gerekir
            List(cryptoListViewModel.cryptoList,id: \.id) {
                crypto in VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                
            }.toolbar(content: {
                Button {
                    //butona tıklaınca url çeksin istiyoruz ama async olmadığı için buton func biz Task.init açarız oto. async bloğu açar:
                    Task.init{
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    } 
                }label: {
                    Text("Refreshing")
                }

            })
            .navigationTitle("Cryptos")
            //datayı çekmek için : yaşam döngüsü funclardan bu görünüm oluşturulunca ne yapacağını söyleriz veri çek:
        }.task {
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            // await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
        /* .onAppear{
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            }*/
    }
}

#Preview {
    MainView()
}
