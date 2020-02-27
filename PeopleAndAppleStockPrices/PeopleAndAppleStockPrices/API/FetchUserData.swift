//
//  FetchTicketMaster.swift
//  AlbertOliveira-CTA
//
//  Created by albert coelho oliveira on 12/2/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//


import Foundation

class FetchUserData{

static let manager = FetchUserData()

 func getUsers(completionHandler: @escaping (Result<[User], AppError>) -> ()) {
    let urlString = "https://randomuser.me/api/?results=500"
    NetWorkManager.shared.fetchData(urlString: urlString){(result) in
                  switch result {
                  case .failure(let error) :
                      completionHandler(.failure(error))
                  case .success(let data):
                    let userData = UserBase.decodeUser(data: data)
                        completionHandler(.success(userData))
            }
        }
    }
    }
    
        
