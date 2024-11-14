//
//  CryptoViewModel.swift
//  CryptoSUI
//
//  Created by Hatice Taşdemir on 7.11.2024.
//

import Foundation

@MainActor //bu sınıfın içeriisndeki propertyler main threadde işlem görecek demek. dispatch eklmeye gerek yok.
class CryptoListViewModel : ObservableObject {
    //observeableobject : cryptoList içinde herhaangi bir değişşiklik olduğunda (mainviewde kullanacağız cryptoListi) mainView kendi kendine yenilensin diye kullanırız: publish olarak kullanılır.
    
    //cryptos alıp kayıt edeceğimiz yer lazım. sonra kayıt edilen yeri viewda kullanacağız.
    @Published var cryptoList = [CryptoViewModel]()
    
    //webserviceden bir obje oluşturduk ilk.
    let webservice = WebService()
    
    func downloadCryptosContinuation(url: URL) async {
        do{
            let cryptos = try await webservice.downloadCurrenciesContinuation(url: url)
            //mainaktor old için bu yeterli olacaktır.
            self.cryptoList = cryptos.map(CryptoViewModel.init)
            
           /* DispatchQueue.main.async {
                //bu func cryptolisti güncellediğinde maini güncelliyor.
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }*/
        }catch{
            print(error)
        }
    }
    
   /* func downloadCryptosAsync(url : URL) async {
            do {
            let cryptos = try await webservice.downloadCurrenciesAsync(url: url)
                DispatchQueue.main.async {
                    self.cryptoList = cryptos.map(CryptoViewModel.init)
                }
            } catch {
                print(error)
            }
        }*/
    
    /* func downloadCryptos(url : URL) {
        //bu funcda web servisi çağırırız ve içindekii func oto. gelir.
        webservice.downloadCurrencies(url: url) { result in
                    //gelen resultı switch ile çalışırız
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let cryptos):
                        //cryptosu optional olmaktan çıkarmak için cryptoCurrency listesine ulaşıp direkt verir bu kod ile:
                        if let cryptos = cryptos{
                            DispatchQueue.main.async{
                                self.cryptoList = cryptos.map(CryptoViewModel.init)
                            }
                            //cryptosda indirdiğimiz verileri cryproliste tanımlama işlemi: ayrıca bir yapıyı başka bir yapıya çevirmek için map kullanılır.
                            
                            }
                    }
                }
        } */
        }
   
    




struct CryptoViewModel{
    //burada sadece modeli alıp burada işleyeceğiz. modelde cryptocurrency diye oluşturduğumuz fileda bulunan propertyleri ekleyeceğiz
    
    let  crypto : CryptoCurrency
    //crypto değişkenini doğru düzgün kullanabilmek için yapılan bir struct.
    var id : UUID? {
        crypto.id
    }
    var currency : String{
        crypto.currency
    }
    var price : String{
        crypto.price
    }
    
    
}
