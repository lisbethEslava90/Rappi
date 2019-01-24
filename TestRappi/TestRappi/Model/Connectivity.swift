//
//  Connectivity.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/22/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
