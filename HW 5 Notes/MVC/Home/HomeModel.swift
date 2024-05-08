//
//  HomeModel.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//

import Foundation

protocol HomeModelProtocol: AnyObject {
    func tookNotes()
}
class HomeModel: HomeModelProtocol {
    
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    
    private var allNotes: [String] = []
    
    
    
    func tookNotes() {
//        allNotes = coreDataService.fetchNotes()
        controller?.doneNotes(notes: allNotes)
       
    }
    
}
