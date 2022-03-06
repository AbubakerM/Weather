//
//  RealmHelper.swift
//  Weather
//
//  Created by Mohammed Abubaker on 06/03/2022.
//

import Foundation
import RealmSwift

class RealmHelper {
    // MARK: - Properties
    static let shared = RealmHelper()
    var realm: Realm { return try! Realm() }
    
    // MARK: - Write Methods
    func insert(_ model: Object) {
        do {
            try realm.write { realm.add(model, update: .all) }
        } catch  {
            print(error)
        }
    }
    
    func delete(_ object: Object) {
        do {
            try realm.write { realm.delete(object) }
        } catch  {
            print(error)
        }
    }
    
    func fetch<T: Object>() -> T? {
        return realm.objects(T.self).first
    }
    
    // MARK: Clear Methods
    func clear() {
        do {
            try realm.write { realm.deleteAll() }
        } catch  {
            print(error)
        }
    }
}
