//
//  DatabaseManager.swift
//  Formulaes
//
//  Created by Aurelia Miyajima on 9/13/23.
//  Copyright © 2023 Aurelia Miyajima. All rights reserved.
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

    // Define columns for history tablea
    let historyId = Expression<Int64>("id")
    let myformula_id = Expression<Int64>("myformula_id")
    let equation = Expression<String>("equation")
    let date = Expression<String>("date")
    private init() {
        let path = "myformula.db"
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let libraryDirectory = paths[0]
        let destinationPath = "\(libraryDirectory)/myformula.db"

        if !FileManager.default.fileExists(atPath: destinationPath) {
            if let bundlePath = Bundle.main.path(forResource: "myformula", ofType: ".db") {
                do {
                    try FileManager.default.copyItem(atPath: bundlePath, toPath: destinationPath)
                } catch {
                    print("Failed to copy .db file from bundle to Library directory: \(error)")
                }
            }
        }
        do {
            connection = try Connection(destinationPath)
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
                //t.foreignKey(myformula_id, references: myformula, id)
            })
            let count = try(connection!.scalar(myformula.count))
            if (count <= 0){
                let exf = StringtoFormula(Formula:"a+b=c",formulaname:"ex.formula ")
                
                insertFormula(name: exf.name, formula: exf.formula, input: exf.inputs.joined(separator: ","), output: exf.outputlist.joined(separator: ","))
            }
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
    func insertHistory(myformulaId: Int64, equation: String, date: String) {
        do {
            let insert = history.insert(self.myformula_id <- myformulaId, self.equation <- equation, self.date <- date)
            try connection?.run(insert)
            print("History insertion successful")
        } catch {
            print("History insertion failed: \(error)")
        }
    }

}
