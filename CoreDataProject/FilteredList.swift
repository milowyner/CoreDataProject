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
    
    init(filterKey: String?, filterValue: String?, @ViewBuilder content: @escaping (T) -> Content) {
        let predicate = filterValue != nil && filterKey != nil ? NSPredicate(format: "%K BEGINSWITH %@", filterKey!, filterValue!) : nil
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        List(objects, id: \.self) { object in
            content(object)
        }
    }
}
