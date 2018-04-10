package product.menager;

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


@WebServlet(name = "DeleteProductServlet", urlPatterns = {"/deleteProduct"})
public class DeleteProductServlet extends HttpServlet {

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
        String del = req.getParameter("id_klient_value");
        String id_nrSeryjny = String.valueOf(session.getAttribute("showNrSeyjny"));
      

        try {

            pst = conn.prepareStatement("delete from produkt where nrseryjny= ?");
            pst.setString(1, id_nrSeryjny);
            int i = pst.executeUpdate();
            conn.close();
            
            if (i != 0) {
                
                session.setAttribute("showNazwa", "");
                session.setAttribute("showRodzaj", "");
                session.setAttribute("showCena", "");
                session.setAttribute("showNrSeryjny", "");
                session.setAttribute("showImage", "");
                
                
             
            } else if (i == 0) {
             
            }
        } catch (Exception e) {
        }
        req.getRequestDispatcher(PAGE).include(req, resp);
    }

}
