//
//  HomeModel.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//

import Foundation

protocol HomeModelProtocol {
    func tookNotes()
}
class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    
    private var allNotes: [String] = ["Run", "Coding", "Walk w friends", "Cook dinner" ]
    
    func tookNotes() {
        controller?.doneNotes(notes: allNotes)
    }
    
}
