package app;

import view.BaseView;
import view.Navigator;
import javafx.application.Application;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.stage.Stage;

/**
 * Starts the JavaFX program. It shows the login screen first,
 * then switches to the dashboard after a successful login.
 */
public class BankingApp extends Application implements Navigator {
    private Stage stage;
    private AppContext context;

    @Override
    public void start(Stage primaryStage) {
        this.stage = primaryStage;
        try {
            context = new AppContext();
        } catch (Exception e) {
            new Alert(Alert.AlertType.ERROR, "Could not start the database:\n" + e.getMessage()).showAndWait();
            return;
        }
        stage.setTitle("Banking System");
        stage.setMinWidth(1000);
        stage.setMinHeight(680);
        showLogin();
        stage.show();
    }

    @Override
    public void showLogin() {
        showScreen("LoginView.fxml");
    }

    @Override
    public void showDashboard() {
        showScreen("DashboardView.fxml");
    }

    /** Loads a screen from its FXML file in the resources folder and puts it in the window. */
    private void showScreen(String fxmlFile) {
        try {
            setRoot(BaseView.load(fxmlFile, context, this).getView());
        } catch (Exception e) {
            new Alert(Alert.AlertType.ERROR, "Could not load " + fxmlFile + ":\n" + e.getMessage()).showAndWait();
        }
    }

    /** Puts a screen in the window (the first time it also loads styles.css). */
    private void setRoot(Parent root) {
        if (stage.getScene() == null) {
            Scene scene = new Scene(root, 1180, 760);
            scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());
            stage.setScene(scene);
        } else {
            stage.getScene().setRoot(root);
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}

