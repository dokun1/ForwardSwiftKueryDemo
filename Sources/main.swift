import SwiftKuery
import SwiftKueryPostgreSQL

class Grades : Table {
    let tableName = "Grades"
    let id = Column("id")
    let course = Column("course")
    let grade = Column("grade")
}

fileprivate func executeSelectQuery(_ connection: PostgreSQLConnection) {
    let query = Select(grades.course, round(avg(grades.grade), to: 1).as("average"), from: grades).group(by: grades.course).having(avg(grades.grade) > 90).order(by: .ASC(avg(grades.grade)))
    connection.execute(query: query) { result in
        if let resultSet = result.asResultSet {
            for title in resultSet.titles {
                print("Column: \(title)")
            }
            for row in resultSet.rows {
                for value in row {
                    print("Row: \(value!)")
                }
            }
        } else if let queryError = result.asError {
            print(queryError)
        }
    }
}

let grades = Grades()

let connection = PostgreSQLConnection(host: "localhost", port: 5432, options: [.databaseName("postgres"), .userName("davidokunibm"), .password("")])
connection.connect { error in
    if let error = error {
        print(error)
    } else {
        print("PostgreSQL connection established")
        executeSelectQuery(connection)
    }
}
