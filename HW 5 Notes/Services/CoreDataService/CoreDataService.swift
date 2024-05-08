//
//  CoreDataService.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//

import CoreData
import UIKit

class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //CRUD operations, CREATE - запись, READ - чтение, UPDATE - обновить, DELETE - удалить
    
    func addNote(id: String, title: String, description: String, date: Date, color: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            return
        }
        
        let note = Note(entity: entity, insertInto: context)
        note.id = note.id
        note.title = title
        note.desc = description
        note.date = date
        note.color = color
        
        appDelegate.saveContext()
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
