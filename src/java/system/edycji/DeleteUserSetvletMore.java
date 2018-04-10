package system.edycji;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import src.PolaczenieDB;


@WebServlet(name = "DeleteUserSetvletMore", urlPatterns = {"/deleteUserMore"})
public class DeleteUserSetvletMore extends HttpServlet {

     private static final String PAGE = "productMenager.jsp";
   
    static Connection conn;
    static PreparedStatement pst;
    static PreparedStatement pst2;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         resp.sendRedirect(PAGE);
    }

    
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          req.setCharacterEncoding("UTF-8");
               HttpSession session = req.getSession();
               
   
        
        conn = PolaczenieDB.getConnection();
//        int delKlient = Integer.parseInt(req.getParameter("id_klient_del"));
        int delProduct = Integer.parseInt(req.getParameter("id_product_del"));
//        String id_email = String.valueOf(session.getAttribute("showEmail"));
        

       
        try {

            pst = conn.prepareStatement("delete from produkt where id_produkt= ?");
            pst.setInt(1, delProduct);
            int i = pst.executeUpdate();
            conn.close();
            
            if (i != 0) {
                
                
                
             
            } else if (i == 0) {
             
            }
        } catch (Exception e) {
        }
        
        req.getRequestDispatcher(PAGE).include(req, resp);
    }
}
