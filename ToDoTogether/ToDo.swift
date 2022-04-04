//
//  ToDo.swift
//  ToDoTogether
//
//  Created by Emre Dogan on 05/04/2022.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable { // We create protocol, whoever uses this that should have an init function of following type. This type is good to handle data on Firestore
    init?(dictionary:[String:Any])
}

struct ToDo {
    var content: String
    var timeStamp: Date
    
    var dictionary:[String:Any] {
        return [
            "content": content,
            "timeStamp": timeStamp
        ]
    }
}

extension ToDo: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let content = dictionary["content"] as? String,
              let timestamp = dictionary["timestamp"] as? Date else {return nil}
        
        self.init(content: content, timeStamp: timestamp)
        
    }
    
}

