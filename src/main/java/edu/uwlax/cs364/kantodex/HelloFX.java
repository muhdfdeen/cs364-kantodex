package edu.uwlax.cs364.kantodex;

import edu.uwlax.cs364.kantodex.database.DatabaseManager;
import edu.uwlax.cs364.kantodex.database.QueryRunner;
import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.Tab;
import javafx.scene.control.TabPane;
import javafx.scene.control.TableView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;
import javafx.stage.Screen;
import javafx.stage.Stage;

public class HelloFX extends Application {

    private DatabaseManager databaseManager;

    public void init(){
        databaseManager = new DatabaseManager();
        databaseManager.connect();
    }

    @Override
    public void start(Stage stage) {
        TabPane tabPane = new TabPane();
        tabPane.setTabClosingPolicy(TabPane.TabClosingPolicy.UNAVAILABLE);

        // Our project should do
        Tab pokedexTab = createPokedexTab();
        Tab teamTab = new Tab("Team Builder", new StackPane(new Label("Team CRUD controls will go here.")));
        Tab queriesTab = new Tab("Advanced Queries", new StackPane(new Label("Advanced SQL queries will go here.")));
        
        tabPane.getTabs().addAll(pokedexTab, teamTab, queriesTab);

        // uses a % ratio to open the GUI
        Rectangle2D screenBounds = Screen.getPrimary().getVisualBounds();
        double width = screenBounds.getWidth() * 0.80;
        double height = screenBounds.getHeight() * 0.80;

        Scene scene = new Scene(tabPane, width, height);
        stage.setTitle("KantoDex");
        stage.setScene(scene);
        stage.show();
    }

    private Tab createPokedexTab() {
        TableView<ObservableList<String>> pokedexTable = new TableView<>();
        QueryRunner.runSqlFileIntoTable(databaseManager.getConnection(), "/pokedex.sql", pokedexTable);

        BorderPane layout = new BorderPane();
        layout.setCenter(pokedexTable);

        return new Tab("Pokédex", layout);
    }

    @Override
    public void stop() {
        if (databaseManager != null) {
            databaseManager.disconnect();
        }
    }
    public static void main(String[] args) {
        launch();
    }
}
