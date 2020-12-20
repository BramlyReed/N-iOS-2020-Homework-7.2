//
//  GetUrl.swift
//  Homework7.2
//
//  Created by Stas on 20.12.2020.
//

import Foundation
import RealmSwift

class GetUrl: Object{
    @objc dynamic var storedUrl: String = ""
    convenience init(tmpurl: String){
        self.init()
        self.storedUrl = tmpurl
    }
}
