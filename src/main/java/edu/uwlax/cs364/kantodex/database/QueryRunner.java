package edu.uwlax.cs364.kantodex.database;

import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

// Not the best but working on it and it works other all are good have to refine this java file - Krish

public class QueryRunner {

    public static void runSqlFileIntoTable(Connection conn, String resourcePath, TableView<ObservableList<String>> tableView) {
        try (InputStream is = QueryRunner.class.getResourceAsStream(resourcePath)) {
            if (is == null) {
                System.err.println("SQL file not found: " + resourcePath);
                return;
            }
            String sql = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            runSqlIntoTable(conn, sql, tableView);
        } catch (Exception e) {
            System.err.println("Error reading SQL file: " + resourcePath);
            e.printStackTrace();
        }
    }

    public static void runSqlIntoTable(Connection conn, String sql, TableView<ObservableList<String>> tableView) {
        tableView.getColumns().clear();
        tableView.getItems().clear();

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            ResultSetMetaData meta = rs.getMetaData();
            int colCount = meta.getColumnCount();

            for (int i = 1; i <= colCount; i++) {
                final int colIndex = i - 1;
                TableColumn<ObservableList<String>, String> col = new TableColumn<>(meta.getColumnLabel(i));
                col.setCellValueFactory(data -> new SimpleStringProperty(data.getValue().get(colIndex)));
                tableView.getColumns().add(col);
            }

            ObservableList<ObservableList<String>> rows = FXCollections.observableArrayList();
            while (rs.next()) {
                ObservableList<String> row = FXCollections.observableArrayList();
                for (int i = 1; i <= colCount; i++) {
                    String val = rs.getString(i);
                    row.add(val != null ? val : "NULL");
                }
                rows.add(row);
            }
            tableView.setItems(rows);

        } catch (Exception e) {
            System.err.println("Error running query into table:");
            e.printStackTrace();
        }
    }
}