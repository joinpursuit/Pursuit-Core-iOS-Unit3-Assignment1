//
//  ContactsAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
enum ContactErrors{
    case badURL (String)
    case badData(Error)
    case badDecoding(Error)
}

final class ContactAPICLient {
    static func searchContacts (searchTerm: String, completionHandler: @escaping([ContactDetails]?,ContactErrors?)->Void){
            guard let url = URL.init(string:"https://api.edamam.com/search?q=\(searchTerm)&app_id=9c3eb43a&app_key=df425612fd80ead90c01dbf38d728275")else{
        completionHandler(nil,.badURL("url failed"))
        return
    }
URLSession.shared.dataTask(with: url){(data, response, error) in
    if let error = error {
        completionHandler(nil, .badData(error))
    }else if let data = data {
        do{
            let contactsSearchData = try
            JSONDecoder().decode(ContactDetails.Contacts.self, from : data)
            completionHandler(contactsSearchData.results, nil)
        }catch{
            completionHandler(nil, .badDecoding(error))
        }
      }
    }.resume()
  }
}

