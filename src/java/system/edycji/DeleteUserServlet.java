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


@WebServlet(name = "DeleteUserServlet", urlPatterns = {"/deleteUser"})
public class DeleteUserServlet extends HttpServlet {

    private static final String PAGE = "accMenager.jsp";
   
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
        String id_email = String.valueOf(session.getAttribute("showEmail"));
      

        try {

            pst = conn.prepareStatement("delete from klient where email= ?");
            pst.setString(1, id_email);
            int i = pst.executeUpdate();
            conn.close();
            
            if (i != 0) {
                
                session.setAttribute("showImie", "");
                session.setAttribute("showNazwisko", "");
                session.setAttribute("showEmail", "");
                session.setAttribute("showTelefon", "");
                session.setAttribute("showHaslo", "");
                session.setAttribute("showRanga", "");
                
             
            } else if (i == 0) {
             
            }
        } catch (Exception e) {
        }
        req.getRequestDispatcher(PAGE).include(req, resp);
    }

}
