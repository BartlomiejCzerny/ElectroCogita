package src;

import java.sql.*;
import src.PolaczenieDB;

public class RejestracjaInsert {
    
    static Connection conn;
    static  PreparedStatement pst;
    static  PreparedStatement pst2;
    
    public static int insertRejestracja(RejestracjaDane u) {
       int status = 0;
        try {
            conn = PolaczenieDB.getConnection();
            pst = conn.prepareStatement("insert into klient(imie,nazwisko,telefon,email,haslo,ranga) values(?,?,?,?,?,'User')");
           
            
            
            pst.setString(1, u.getImie());
            pst.setString(2, u.getNazwisko());
            pst.setString(3, u.getTelefon());
            pst.setString(4, u.getEmail());
            pst.setString(5, u.getHaslo());
            status = pst.executeUpdate();
//            pst2 = conn.prepareStatement("insert into uprawnienia(email,ranga) values(?,'user')");
//            
//            pst2.setString(1, u.getEmail());
//            status = pst2.executeUpdate();
            
            conn.close();
            
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        return status;
    }
    
}