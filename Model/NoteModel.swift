//
//  NoteModel.swift
//  NotesKeeper
//
//  Created by G50 on 5/15/20.
//  Copyright © 2020 NotesKeeper. All rights reserved.
//

import Foundation

class Note {
    
    let noteTitle :String
    let notePriority : String
    
    init(noteTitle : String , notePriority : String) {
        
       self.noteTitle = noteTitle
       self.notePriority = notePriority
        
    }
    
}



