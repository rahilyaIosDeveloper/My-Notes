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
        note.id = id
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
    
    func updateNote(id: String, title: String, description: String, date: Date) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id
            }) else {
                return
            }
            note.title = title
            note.desc = description
            note.date = date
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func delete(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note =
                    notes.first(where: { note in
                    note.id == id
                    }) else {
                return
            }
                context.delete(note)
            
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    
    
    
    func deleteAllNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note]
            else {
                return
            }
            notes.forEach { note in
                context.delete(note)
            }
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    
    
}
