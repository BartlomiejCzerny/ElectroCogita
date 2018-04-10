package product.menager;

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
import src.PolaczenieDB;


@WebServlet(name = "EditProductServlet", urlPatterns = {"/editProduct"})
public class EditProductServlet extends HttpServlet {

   private static final String PAGE = "productMenager.jsp";

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
        
        String id_nrSeryjny = req.getParameter("id_nrSeryjny");

        HttpSession session = req.getSession();
        ResultSet res = null;

        conn = PolaczenieDB.getConnection();

        if (btnSearch != null) {
            req.setAttribute("tableShow", true);
            if (Integer.parseInt(btnSearch) > 0) {
                try {

                    statement = conn.createStatement();
                    String data = "select nazwa, rodzaj, cena, nrseryjny, image from produkt where nrseryjny ='" + id_nrSeryjny + "'";
                    resultSet = statement.executeQuery(data);

                    while (resultSet.next()) {

                        
                    
                        req.setAttribute("showNazwa", resultSet.getString("nazwa"));
                        req.setAttribute("showRodzaj", resultSet.getString("rodzaj"));
                        req.setAttribute("showCena", resultSet.getString("cena"));
                        req.setAttribute("showNrSeryjny", resultSet.getString("nrseryjny"));
                        req.setAttribute("showImage", resultSet.getString("image"));
                        

                        session.setAttribute("showNazwa", resultSet.getString("nazwa"));
                        session.setAttribute("showRodzaj", resultSet.getString("rodzaj"));
                        session.setAttribute("showCena", resultSet.getString("cena"));
                        session.setAttribute("showNrSeryjny", resultSet.getString("nrseryjny"));
                        session.setAttribute("showImage", resultSet.getString("image"));
                       

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
                String data = "select nazwa, rodzaj, cena, nrseryjny, image from produkt where nrseryjny ='" + id_nrSeryjny + "'";
                resultSet = statement.executeQuery(data);
                while (resultSet.next()) {

                        req.setAttribute("showNazwa", resultSet.getString("nazwa"));
                        req.setAttribute("showRodzaj", resultSet.getString("rodzaj"));
                        req.setAttribute("showCena", resultSet.getString("cena"));
                        req.setAttribute("showNrSeryjny", resultSet.getString("nrseryjny"));
                        req.setAttribute("showImage", resultSet.getString("image"));
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
                ps = conn.prepareCall("UPDATE produkt SET nazwa=?, rodzaj=?, cena=?, nrseryjny=?, image=? where nrseryjny ='"+session.getAttribute("showNrSeryjny")+"';");
                ps.setString(1, req.getParameter("nazwaE"));
                ps.setString(2, req.getParameter("rodzajE"));
                ps.setDouble(3, Double.parseDouble(req.getParameter("cenaE")));
                ps.setString(4, req.getParameter("nrseryjnyE"));
                ps.setString(5, req.getParameter("imageE"));
              
                int wynik = ps.executeUpdate();

                        session.setAttribute("showNazwa", req.getParameter("nazwaE"));
                        session.setAttribute("showRodzaj", req.getParameter("rodzajE"));
                        session.setAttribute("showCena", req.getParameter("cenaE"));
                        session.setAttribute("showNrSeryjny", req.getParameter("nrseryjnyE"));
                        session.setAttribute("showImage", req.getParameter("imageE"));
                     
                
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
