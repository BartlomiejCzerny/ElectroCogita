package system.rejestracji;

import java.sql.Connection;
import java.sql.PreparedStatement;
import src.PolaczenieDB;


public class RegisterDao {
    
    static Connection conn;
    static  PreparedStatement pst;
    
    
    public static int insertRegister(RegisterBean u) {
       int status = 0;
       if(u.getImie().isEmpty() || u.getNazwisko().isEmpty()|| u.getTelefon().isEmpty() || u.getEmail().isEmpty() || u.getHaslo().isEmpty()){
           status = 0;
           return status;
       }
        try {
            conn = PolaczenieDB.getConnection();
            pst = conn.prepareStatement("insert into klient(imie,nazwisko,telefon,email,haslo,ranga) values(?,?,?,?,?,'User')");
           
            
            
            pst.setString(1, u.getImie());
            pst.setString(2, u.getNazwisko());
            pst.setString(3, u.getTelefon());
            pst.setString(4, u.getEmail());
            pst.setString(5, u.getHaslo());
            status = pst.executeUpdate();
            conn.close();
            
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        return status;
    }
}
