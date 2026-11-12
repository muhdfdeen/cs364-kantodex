package edu.uwlax.cs364.kantodex.database;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseManager {

    private String url;
    private String username;
    private String password;
    private String dbName = "neupane6781_KantoDex";	 
    private Connection connection;

    public DatabaseManager(){
        loadCredential();
    }

    private void loadCredential() {
        Properties props = new Properties();
        // Looks for database.properties inside src/main/resources
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("database.properties")) {
            if (input == null) {
                System.err.println("Error: database.properties file not found in src/main/resources/");
                return;
            }

            props.load(input);

            // Assign variables from properties
            this.url = props.getProperty("db.url");
            this.username = props.getProperty("db.username");
            this.password = props.getProperty("db.password");

        }catch (IOException e) {
            System.err.println("Error reading database.properties file");
            e.printStackTrace();
        }
    }
    public void connect() {
        if (url == null || username == null) {
            System.err.println("Can't connect to the database : configuration are not loaded properly ");
        }

        try{
            String fullUrl = url + dbName;
            connection = DriverManager.getConnection(fullUrl,username,password);
            System.out.print("Successfully connected to the database:" + dbName);
        }catch (SQLException e) {
            System.err.println("can't connect to the database");
            e.printStackTrace();
        }
    }

    public void disconnect() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database Connection closed");

            }
        }catch (SQLException e) {
            System.err.println("Can't disconnect from the database");
            e.printStackTrace();
        }
    }

    // Exposes the active connection to other classes.
    public Connection getConnection() {
        return this.connection;
    }
}
