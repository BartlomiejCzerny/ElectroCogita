package shopping.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import src.PolaczenieDB;
import system.rejestracji.RegisterBean;
import shopping.cart.Cart2;


@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {
     static Connection conn;
    static  PreparedStatement pst;
     static  PreparedStatement pst2;
     ResultSet res = null;
     Statement stat = null;
     
    
     private static final String PAGE2 = "orderSuccess.jsp";
     private static final String PAGE3 = "index.jsp";
   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
        HttpSession session = req.getSession();
        
      
        int status = 0;
        int statusOrdfer = 0;
        
        String sumConvert;
        String id_klientConvert;
        double sumOrder = 0;
        int id_seria_zamowienia = 0;
        int id_klentaSession = 0;
        int id_id_zap = 0;
        
        int getEmail= 0;
        String sessionEmail;
        
//                 PrintWriter out = resp.getWriter();
//        
        sumConvert = String.valueOf(session.getAttribute("sumOreder"));
        sumOrder = Double.parseDouble(sumConvert);
//       out.println(sumOrder);
//                        req.getRequestDispatcher(PAGE).include(req, resp);
 
         try {
            
              conn = PolaczenieDB.getConnection(); 
              stat = conn.createStatement();
              res = stat.executeQuery("select max(IdZamowieniaP) AS maxValue from ZamowienieProdukt");
              res.next();
              id_seria_zamowienia = res.getInt("maxValue") +1;
              conn.close();
//              out.println(res.getInt("LargestPrice"));
                
          } catch (Exception e) {
//              out.println("syf");
        }
        
      
        try {
            List<Cart2> list = (List<Cart2>) session.getAttribute("list");


            for (int i = 0; i < list.size(); i++) {
                conn = PolaczenieDB.getConnection();

                String id_produktu_list = String.valueOf(list.get(i));

                int id_produktu = Integer.parseInt(id_produktu_list);

                pst = conn.prepareStatement("insert into ZamowienieProdukt(IdZamowieniaP,idproduktu) values(?,?)");

                pst.setInt(1, id_seria_zamowienia);
                pst.setInt(2, id_produktu);
                status = pst.executeUpdate();
                conn.close();
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        
                try {

              conn = PolaczenieDB.getConnection(); 
              stat = conn.createStatement();
              res = stat.executeQuery("select max(IdZamP) AS maxValue from ZamowienieProdukt");
              res.next();
              id_id_zap = res.getInt("maxValue");
              conn.close();
              
              sessionEmail = String.valueOf(session.getAttribute("getEmail"));
              
              conn = PolaczenieDB.getConnection(); 
              stat = conn.createStatement();
              res = stat.executeQuery("select idklienta from klient where email='"+sessionEmail+"'");
              res.next();
              getEmail = res.getInt("idklienta");
              conn.close();
              
              
//              
//              out.println(id_id_zap);
//              out.println(getEmail);
//              out.println(id_seria_zamowienia);
//              out.println(sumOrder);
              
          

              conn = PolaczenieDB.getConnection();

              pst2 = conn.prepareStatement("insert into ZamowienieKlient(IdZamP,idklienta,IdZamowieniaK,suma) values(?,?,?,?)");

              pst2.setInt(1, id_id_zap);
              pst2.setInt(2, getEmail);
              pst2.setInt(3, id_seria_zamowienia );
              pst2.setDouble(4, sumOrder);
              statusOrdfer = pst2.executeUpdate();
              
              if(statusOrdfer > 0){
                  
                req.getRequestDispatcher(PAGE2).include(req, resp);
              }else{
                  req.getRequestDispatcher(PAGE3).include(req, resp);
              }

                
          } catch (Exception e) {
//              out.println("syf");
        }
        
        
        
            

    }

}