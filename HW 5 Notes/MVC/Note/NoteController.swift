////
////  NoteController.swift
////  HW 5 Notes
////
////  Created by Rahilya Nazaralieva on 8/5/24.
////


import Foundation
import UIKit

protocol NoteControllerProtocol: AnyObject {
    
    func onAddNote(title: String, description: String, color: String)
    func onSuccessSave()
    func onFailureSave()
    func onDeleteNote(id: String)
    func onSuccessDelete()
    func onFailureDelete()
    func onSuccessUpdateNote(note: Note?, id: String, title: String, description: String, date: Date)
}
    
class NoteController: NoteControllerProtocol {
   
    
    weak var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
    func onAddNote(title: String, description: String, color: String) {
        model?.addNote(title: title, description: description, color: color)
    }
    func onSuccessSave() {
        view?.successSave()
    }
    func onFailureSave() {
        view?.failuresave()
    }
    func onDeleteNote(id: String) {
        model?.deleteNote(id: id)
    }
    func onSuccessDelete() {
        view?.successDelete()
    }
    func onFailureDelete() {
        view?.failureDelete()
    }
    func onSuccessUpdateNote(note: Note?, id: String, title: String, description: String, date: Date) {
        view?.successUpdateNote()
    }
}


