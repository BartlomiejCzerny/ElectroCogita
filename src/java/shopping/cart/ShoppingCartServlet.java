package shopping.cart;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import src.PolaczenieDB;


@WebServlet(name = "ShoppingCartServlet", urlPatterns = {"/shoppingcart"})
public class ShoppingCartServlet extends HttpServlet {

   private static final String PAGE = "products.jsp";
   private static final String PAGE2 = "shoppingCard.jsp";
   private static final String PAGE3 = "emptyCard.jsp";
   
    static Connection conn;
    static PreparedStatement pst;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         resp.sendRedirect(PAGE);
    }

    
        @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        conn = PolaczenieDB.getConnection();
        
        PrintWriter out = resp.getWriter();
        
        
        String btnOrder = req.getParameter("btnOrder");
        
         if (btnOrder == null) {   
         }else{
         
             out.println("Thank you for your order");
         }
         
         

        List<Integer> list = (List<Integer>) session.getAttribute("list");

        if (Boolean.valueOf(req.getParameter("iconCard")) != true) {  // kiedy dodajemy gry do koszyka
            int id_product = Integer.parseInt(req.getParameter("btnBuy"));
            if (list == null) {
                list = new ArrayList<>();
            }
            list.add(id_product);

            session.setAttribute("list", list);

        }

        if (Boolean.valueOf(req.getParameter("iconCard")) == true) { // kiedy przechodzimy do koszyka jeśli lista jest pusta
            if (list == null) {
                list = new ArrayList<>();
            }
            if (list.isEmpty()) {
                req.setAttribute("emptyCard", "Your shoping card is empty :(");

                req.getRequestDispatcher(PAGE3).forward(req, resp);
            }

        }

        if (Boolean.valueOf(req.getParameter("iconCard")) == true && !list.isEmpty()) { // do koszyka lista cos zawiera
            req.setAttribute("anyProduct", true);
            req.getRequestDispatcher(PAGE2).forward(req, resp);
        }

        for (int i = 0; i < list.size(); i++) {
//            out.println("Name " + list.get(i));
        }

        req.getRequestDispatcher(PAGE).include(req, resp);
    }

}
