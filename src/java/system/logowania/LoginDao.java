package system.logowania;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import system.logowania.LoginBean;
import src.PolaczenieDB;

public class LoginDao {

    public String authenticateUser(LoginBean loginBean) {
        String email = loginBean.getEmail();
        String haslo = loginBean.getHaslo();

        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;

        String emailDB = "";
        String hasloDB = "";
        String rangaDB = "";

        try {
            con = PolaczenieDB.getConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("select email,haslo,ranga from klient");

            while (resultSet.next()) {
                emailDB = resultSet.getString("email");
                hasloDB = resultSet.getString("haslo");
                rangaDB = resultSet.getString("ranga");

                if (email.equals(emailDB) && haslo.equals(hasloDB) && rangaDB.equals("Admin")) {
                    return "Admin_Role";
                } else if (email.equals(emailDB) && haslo.equals(hasloDB) && rangaDB.equals("Pracownik")) {
                    return "Pracownik_Role";
                } else if (email.equals(emailDB) && haslo.equals(hasloDB) && rangaDB.equals("User")) {
                    return "User_Role";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Incorrect email or password";
    }
}
