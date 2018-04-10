package product.menager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import src.PolaczenieDB;


public class ProductDao {
    
    static Connection conn;
    static PreparedStatement pst;
    
    public static int insertProduct(ProductBean p){
        int status = 0; 
        if (p.getNazwa().isEmpty() || p.getRodzaj().isEmpty() || p.getNrSeryjny().isEmpty()){
            status =0;
            return status;
        }
        
        try {
            conn = PolaczenieDB.getConnection();
            pst = conn.prepareStatement("insert into produkt(nazwa, rodzaj, cena, nrseryjny, image) values(?,?,?,?,?)");
            
            
            pst.setString(1, p.getNazwa());
            pst.setString(2, p.getRodzaj());
            pst.setDouble(3, p.getCena());
            pst.setString(4, p.getNrSeryjny());
            pst.setString(5, p.getImage());
            status = pst.executeUpdate();
            conn.close();
            
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
      return status;
    }
    
    
}
