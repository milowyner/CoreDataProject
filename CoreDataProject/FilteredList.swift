//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Milo Wyner on 8/26/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Property: Comparable, RowContent: View>: View {
    var fetchRequest: FetchRequest<T>
    var objects: FetchedResults<T> { fetchRequest.wrappedValue }
    let rowContent: (T) -> RowContent
    
    init(filter: String?, property: KeyPath<T, Property>?, @ViewBuilder rowContent: @escaping (T) -> RowContent) {
        let predicate = filter != nil && property != nil ? NSPredicate(format: "\(NSExpression(forKeyPath: property!)) BEGINSWITH %@", filter!) : nil
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: predicate)
        self.rowContent = rowContent
    }
    
    var body: some View {
        List(objects, id: \.self) { object in
            rowContent(object)
        }
    }
}
