//
//  HomeController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//


protocol HomeControllerProtocol {
    func takeNotes()
    
    func doneNotes(notes: [String])
}

class HomeController: HomeControllerProtocol {
    
    
    private var view: HomeViewProtocol?
    private var model: HomeModelProtocol?
    
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func takeNotes() {
        model?.tookNotes()
    }
    
    func doneNotes(notes: [String]) {
        view?.doneNotes(allNotes: notes)
    }
}
