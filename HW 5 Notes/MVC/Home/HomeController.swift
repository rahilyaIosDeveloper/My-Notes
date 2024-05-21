//
//  HomeController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//


protocol HomeControllerProtocol {
    func takeNotes()
    func doneNotes(notes: [Note])
    func onFailureNotes()
    func onSearchNote(title: String)
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
    
    func doneNotes(notes: [Note]) {
        view?.doneNotes(allNotes: notes)
    }
    func onFailureNotes() {
        view?.failureNotes()
    }
    func onSearchNote(title: String) {
        model?.searchNote(title: title)
    }
    
}
