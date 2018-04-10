package shopping.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static shopping.cart.OrderServlet.conn;
import src.PolaczenieDB;


@WebServlet(name = "DeleteProductCard", urlPatterns = {"/deleteCard"})
public class DeleteProductCard extends HttpServlet {
   private static final String PAGE = "shoppingCard.jsp";
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
  
        HttpSession session = req.getSession();

       
        PrintWriter out = resp.getWriter();
        String test;
        
        int id_del = 0;
        
          test = String.valueOf(session.getAttribute("delCard"));
          
          id_del = Integer.parseInt(test);
          
       
        try {
            List<Cart2> list = (List<Cart2>) session.getAttribute("list");
                
            for(int i = 0; i<list.size(); i++){
            
               if(list.contains(id_del)){
                   list.remove(i);
                   req.setAttribute("anyProduct", true);
                   
                   break;
               }else{
//                out.println("Nie");
               }

              
                
            }

              
               session.setAttribute("delCard", null);
            
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
                
        
        req.getRequestDispatcher(PAGE).forward(req, resp);
              
              

                  
             

        
        
        
            

    }
 
}
