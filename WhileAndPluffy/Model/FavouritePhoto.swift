//
//  FavouritePhoto.swift
//  WhileAndPluffy
//
//  Created by Kirill Drozdov on 04.06.2022.
//

import Foundation
import RealmSwift

class FavouritePhoto: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var createdAT: String = ""
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var isFavourite: Bool = false
}
