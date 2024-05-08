//
//  NoteController.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//

import Foundation
import UIKit

protocol NoteControllerProtocol: AnyObject {
}

class NoteController: NoteControllerProtocol {
    weak var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
}
