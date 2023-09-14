//
//  DatabaseManager.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 9/13/23.
//  Copyright © 2023 Michael Miyajima. All rights reserved.
//

import Foundation
import SQLite
class DatabaseManager {
    static let shared = DatabaseManager()
    var connection: Connection?
    let myformula = Table("myformula")
    let history = Table("history")

    // Define columns for myformula table
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let formula = Expression<String?>("formula")
    let input = Expression<String?>("input")
    let output = Expression<String?>("output")

    // Define columns for history table
    let historyId = Expression<Int64>("id")
    let myformula_id = Expression<Int64>("myformula_id")
    let equation = Expression<String>("equation")
    let date = Expression<String>("date")
    private init() {
        let path = "./myformula.db"
        do {
            connection = try Connection(path)
            try connection!.run(myformula.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(name)
                t.column(formula)
                t.column(input)
                t.column(output)
            })

            // Create the history table if it doesn't exist
            try connection!.run(history.create(ifNotExists: true) { t in
                t.column(historyId, primaryKey: .autoincrement)
                t.column(myformula_id)
                t.column(equation)
                t.column(date)
                t.foreignKey(myformula_id, references: myformula, id)
            })
            
        } catch {
            connection = nil
            print("Unable to open database: \(error)")
        }
    }
    func insertFormula(name: String, formula: String?, input: String?, output: String?) {
        do {
            let insert = myformula.insert(self.name <- name, self.formula <- formula, self.input <- input, self.output <- output)
            try connection?.run(insert)
            print("Insertion successful")
        } catch {
            print("Insertion failed: \(error)")
        }
    }

}
