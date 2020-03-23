def updateTable(table, column, variable, row, index)
    @db.execute(
            "UPDATE '#{table}' SET '#{column}' = ? WHERE #{row} = ?",
                                          [variable,          index]
        )
end