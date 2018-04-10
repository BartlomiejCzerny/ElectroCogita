package system.edycji;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.postgresql.jdbc2.optional.ConnectionPool;
import src.PolaczenieDB;


@WebServlet(name = "EditUserServlet", urlPatterns = {"/editUser"})
public class EditUserServlet extends HttpServlet {

    private static final String PAGE = "accMenager.jsp";

    static Connection conn;

    static Statement statement = null;
    static ResultSet resultSet = null;
     private int showTable = 0;
    private int showEdit = 0;
    private int showNo = 0;
    private int showYes = 0;
    private int showAll = 0;
    static PreparedStatement ps = null;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(PAGE);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String btnEdit = req.getParameter("btnEdit");
        String btnNo = req.getParameter("btnNo");
        String btnYes = req.getParameter("btnYes");
        String btnSearch = req.getParameter("search");
        String btnShowAll = req.getParameter("showAll");
        
        String id_email = req.getParameter("id_email");

        HttpSession session = req.getSession();
        ResultSet res = null;

        conn = PolaczenieDB.getConnection();

        if (btnSearch != null) {
            req.setAttribute("tableShow", true);
            if (Integer.parseInt(btnSearch) > 0) {
                try {

                    statement = conn.createStatement();
                    String data = "select imie, nazwisko, email, telefon, haslo, ranga from klient where email ='" + id_email + "'";
                    resultSet = statement.executeQuery(data);

                    while (resultSet.next()) {

                        
                    
                        req.setAttribute("showImie", resultSet.getString("imie"));
                        req.setAttribute("showNazwisko", resultSet.getString("nazwisko"));
                        req.setAttribute("showTelefon", resultSet.getString("telefon"));
                        req.setAttribute("showEmail", resultSet.getString("email"));
                        req.setAttribute("showHaslo", resultSet.getString("haslo"));
                        req.setAttribute("showRanga", resultSet.getString("ranga"));

                        session.setAttribute("showImie", resultSet.getString("imie"));
                        session.setAttribute("showNazwisko", resultSet.getString("nazwisko"));
                        session.setAttribute("showTelefon", resultSet.getString("telefon"));
                        session.setAttribute("showEmail", resultSet.getString("email"));
                        session.setAttribute("showHaslo", resultSet.getString("haslo"));
                        session.setAttribute("showRanga", resultSet.getString("ranga"));

                    }

                    conn.close();
                } catch (Exception e) {
                }

            }
        }
        
        
        if (btnShowAll != null) {
            showAll = Integer.parseInt(btnShowAll);
            
        }
        if(showAll > 0){
            req.setAttribute("showAll", true);
            req.setAttribute("showAllHide", false);
            req.setAttribute("tableShow", false);
            
            
            showAll = 1;
        }
        

        if (btnEdit != null) {
            showEdit = Integer.parseInt(btnEdit);
        }
        if (btnNo != null) {
            showNo = Integer.parseInt(btnNo);
        }
        if (btnYes != null) {
            showYes = Integer.parseInt(btnYes);
        }

        if(showTable > 0){
            
            req.setAttribute("searchShow", true);
            showEdit = 0;
            
        }else if (showEdit > 0 || btnEdit != null) {
            
            try {
                String data = "select imie, nazwisko, email, telefon, haslo from klient where email ='" + id_email + "'";
                resultSet = statement.executeQuery(data);
                while (resultSet.next()) {

                    req.setAttribute("showImie", resultSet.getString("imie"));
                    req.setAttribute("showNazwisko", resultSet.getString("nazwisko"));
                    req.setAttribute("showEmail", resultSet.getString("email"));
                    req.setAttribute("showTelefon", resultSet.getString("telefon"));
                    req.setAttribute("showHaslo", resultSet.getString("haslo"));
                    req.setAttribute("showRanga", resultSet.getString("ranga"));
                }
            } catch (Exception e) {
            }
            req.setAttribute("searchShow", true);
            req.setAttribute("tableShow", true);
            
            showEdit = 0;

        } else if (showNo > 0 || btnNo != null) {
            req.setAttribute("searchShow", false);
            req.setAttribute("tableShow", true);
            showEdit = 0;

        } else if ((showYes > 0 || btnNo != null) && (showAll !=1 || btnShowAll == null)) {

            try {

                String v = String.valueOf(session.getAttribute("email"));
//                    ps = conn.prepareCall("UPDATE klient SET imie=?, nazwisko=?, telefo=?, email=?, haslo=? where email ='11'");
                ps = conn.prepareCall("UPDATE klient SET imie=?, nazwisko=?, telefon=?, email=?, haslo=?, ranga=? where email ='"+session.getAttribute("showEmail")+"';");
                ps.setString(1, req.getParameter("imieE"));
                ps.setString(2, req.getParameter("nazwiskoE"));
                ps.setString(3, req.getParameter("telefonE"));
                ps.setString(4, req.getParameter("emailE"));
                ps.setString(5, req.getParameter("hasloE"));
                ps.setString(6, req.getParameter("rangaE"));
                int wynik = ps.executeUpdate();

                 session.setAttribute("showImie", req.getParameter("imieE"));
                        session.setAttribute("showNazwisko", req.getParameter("nazwiskoE"));
                        session.setAttribute("showEmail", req.getParameter("telefonE"));
                        session.setAttribute("showTelefon", req.getParameter("emailE"));
                        session.setAttribute("showHaslo", req.getParameter("hasloE"));
                        session.setAttribute("showRanga", req.getParameter("rangaE"));
                
                conn.close();
                
///////////////////////////////////////////////////
            } catch (Exception e) {
            }

            try {

            } catch (Exception e) {
            }

            req.setAttribute("searchShow", false);
            req.setAttribute("tableShow", true);
            showEdit = 0;

        } else {
            req.setAttribute("searchShow", false);
            
            
            showEdit = 0;
        }
        
          if(showAll != 0){
            req.setAttribute("tableShow", false);
          
            showAll = 0;
        }

        req.getRequestDispatcher(PAGE).include(req, resp);
    }

}
