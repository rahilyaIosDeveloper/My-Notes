//
//  NoteModel.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//

import Foundation
import UIKit

protocol NoteModelProtocol {
}

class NoteModel: NoteModelProtocol {
    private let coreDataService = CoreDataService.shared
    
    var controller: NoteControllerProtocol?
    
    init(controller: NoteControllerProtocol) {
        self.controller = controller
    }
    
}
