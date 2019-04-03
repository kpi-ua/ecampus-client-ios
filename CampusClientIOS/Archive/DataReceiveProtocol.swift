//
//  DataReceiveProtocol.swift
//  CampusClientIOS
//
//  Created by Денис Ефремов on 4/3/19.
//  Copyright © 2019 SINED. All rights reserved.
//

import Foundation

protocol DataReceiveProtocol: class {
    func dataReceive(data: [VoteTerms: [ArchiveResults]])
}
