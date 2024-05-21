//
//  HomeModel.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//

import Foundation

protocol HomeModelProtocol: AnyObject {
    func tookNotes()
    func searchNote(title: String)
}

class HomeModel: HomeModelProtocol {
    

    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    private var filteredNotes: [Note] = []
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
        
    private var allNotes: [Note] = []
    
    func tookNotes() {
        allNotes = coreDataService.fetchNotes { response in
            if response == .success {
                self.controller?.doneNotes(notes: self.allNotes)
            } else {
                self.controller?.onFailureNotes()
            }
        }
    }
    func searchNote(title: String) {
        filteredNotes = []
        let searchedTitle = title.uppercased()
        
        if searchedTitle.isEmpty {
            filteredNotes = allNotes
        } else {
            filteredNotes = allNotes.filter({ note in
                note.title?.uppercased().contains(searchedTitle) == true
            })
        }
        controller?.doneNotes(notes: filteredNotes)
    }
}
