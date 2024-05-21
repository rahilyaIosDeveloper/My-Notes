////
////  CoreDataService.swift
////  HW 5 Notes
////
////  Created by Rahilya Nazaralieva on 8/5/24.
////
//
//import CoreData
//import UIKit
//
//enum CoreDataResponse {
//    case success
//    case failure
//}
//
//class CoreDataService {
//    static let shared = CoreDataService()
//    
//    private init() {
//    }
//    
//    private var appDelegate: AppDelegate {
//        UIApplication.shared.delegate as! AppDelegate
//    }
//    
//    private var context: NSManagedObjectContext {
//        appDelegate.persistentContainer.viewContext
//    }
//    
//    //CRUD operations, CREATE - запись, READ - чтение, UPDATE - обновить, DELETE - удалить
//    
//    func addNote(id: String, title: String, description: String, date: Date, color: String, completionHandler: @escaping (CoreDataResponse) -> ()) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
//        else {
//            DispatchQueue.main.sync {
//                completionHandler(.failure)
//            }
//            return
//        }
//        
//        let note = Note(entity: entity, insertInto: context)
//        note.id = id
//        note.title = title
//        note.desc = description
//        note.date = date
//        note.color = color
//        
//        appDelegate.saveContext()
//        DispatchQueue.main.sync {
//            completionHandler(.success)
//        }
//    }
//    
//    func fetchNotes(completionHandler: @escaping (CoreDataResponse) -> ()) -> [Note] {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//        do {
//            completionHandler(.success)
//            return try context.fetch(fetchRequest) as! [Note]
//        } catch {
//            completionHandler(.failure)
//            print(error.localizedDescription)
//        }
//        return []
//    }
//    
//    func updateNote(id: String, title: String, description: String, date: Date) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//        do {
//            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
//                note.id == id
//            }) else { return }
//            note.title = title
//            note.desc = description
//            note.date = date
//        } catch {
//            print(error.localizedDescription)
//        }
//        appDelegate.saveContext()
//    }
//    
//
//    func delete(id: String, completionHandler: @escaping (CoreDataResponse) -> Void) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//        do {
//            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
//                note.id == id
//            }) else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure)
//                }
//                return
//            }
//            context.delete(note)
//            DispatchQueue.main.async {
//                completionHandler(.success)
//            }
//        } catch {
//            DispatchQueue.main.async {
//                completionHandler(.failure)
//            }
//        }
//        appDelegate.saveContext()
//    }
//    
//    func deleteAllNotes(completionHandler: @escaping (CoreDataResponse) -> Void) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//        do {
//            guard let notes = try context.fetch(fetchRequest) as? [Note] else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure)
//                }
//                return
//            }
//            notes.forEach { note in context.delete(note)
//            }
//            DispatchQueue.main.async {
//                completionHandler(.success)
//            }
//        } catch {
//            completionHandler(.failure)
//        }
//        appDelegate.saveContext()
//    }
//}
//
//

import CoreData
import UIKit

enum CoreDataResponse {
    case success
    case failure
}

class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {
    }
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private var context: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
    
    // CRUD operations, CREATE - запись, READ - чтение, UPDATE - обновить, DELETE - удалить
    
    func addNote(id: String, title: String, description: String, date: Date, color: String, completionHandler: @escaping (CoreDataResponse) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let context = self.context else {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
                return
            }
            guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
                return
            }
            
            let note = Note(entity: entity, insertInto: context)
            note.id = id
            note.title = title
            note.desc = description
            note.date = date
            note.color = color
            
            self.appDelegate?.saveContext()
            DispatchQueue.main.async {
                completionHandler(.success)
            }
        }
    }
    
    func fetchNotes(completionHandler: @escaping (CoreDataResponse) -> ()) -> [Note] {
        guard let context = self.context else {
            DispatchQueue.main.async {
                completionHandler(.failure)
            }
            return []
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let notes = try context.fetch(fetchRequest) as! [Note]
            DispatchQueue.main.async {
                completionHandler(.success)
            }
            return notes
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure)
                print(error.localizedDescription)
            }
            return []
        }
    }
    
    func updateNote(id: String, title: String, description: String, date: Date) {
        DispatchQueue.global(qos: .background).async {
            guard let context = self.context else {
                return
            }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { $0.id == id }) else { return }
                note.title = title
                note.desc = description
                note.date = date
                self.appDelegate?.saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(id: String, completionHandler: @escaping (CoreDataResponse) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let context = self.context else {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
                return
            }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { $0.id == id }) else {
                    DispatchQueue.main.async {
                        completionHandler(.failure)
                    }
                    return
                }
                context.delete(note)
                self.appDelegate?.saveContext()
                DispatchQueue.main.async {
                    completionHandler(.success)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
            }
        }
    }
    
    func deleteAllNotes(completionHandler: @escaping (CoreDataResponse) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let context = self.context else {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
                return
            }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                guard let notes = try context.fetch(fetchRequest) as? [Note] else {
                    DispatchQueue.main.async {
                        completionHandler(.failure)
                    }
                    return
                }
                notes.forEach { context.delete($0) }
                self.appDelegate?.saveContext()
                DispatchQueue.main.async {
                    completionHandler(.success)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
            }
        }
    }
}
