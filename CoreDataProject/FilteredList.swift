//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Milo Wyner on 8/26/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var objects: FetchedResults<T> { fetchRequest.wrappedValue }
    let content: (T) -> Content
    
    init(filterKey: String?, filterPredicate: String?, filterValue: String?, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        let predicate = filterValue != nil && filterKey != nil && filterPredicate != nil ? NSPredicate(format: "%K \(filterPredicate!) %@", filterKey!, filterValue!) : nil
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        List(objects, id: \.self) { object in
            content(object)
        }
    }
}
