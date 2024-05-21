//
//  NoteModel.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//

import Foundation
import UIKit

protocol NoteModelProtocol: AnyObject {
    func addNote(title: String, description: String, color: String)
    func deleteNote(id: String)
    func updateNote(note: Note?, id: String, title: String, description: String, date: Date)
}

class NoteModel: NoteModelProtocol {
    
    weak var controller: NoteControllerProtocol?
    private let coreDataService = CoreDataService.shared
    
 

    init(controller: NoteControllerProtocol) {
        self.controller = controller
    }
    
    func addNote(title: String, description: String, color: String) {
        let id = UUID().uuidString
        let date = Date()
        
        coreDataService.addNote(id: id, title: title, description: description, date: date, color: color) { response  in
            if response == .success {
                self.controller?.onSuccessSave()
            } else {
                self.controller?.onFailureSave()
            }
        }
    }
    
    func updateNote(note: Note?, id: String, title: String, description: String, date: Date) {
         if let note = note {
             coreDataService.updateNote(id: note.id ?? "", title: title, description: description, date: date)
         }
         controller?.onSuccessUpdateNote(note: note, id: id, title: title, description: description, date: date)
     }
    func deleteNote(id: String) {
        coreDataService.delete(id: id) { response in
            if response == .success {
                self.controller?.onSuccessDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
    }
}
