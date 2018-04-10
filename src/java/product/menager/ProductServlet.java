package product.menager;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import system.rejestracji.RegisterBean;
import system.rejestracji.RegisterDao;


@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {
    
    private static final String PAGE = "productMenager.jsp";
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       resp.sendRedirect(PAGE);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        String  nazwa = req.getParameter("nazwa");
        String rodzaj = req.getParameter("rodzaj");
        String cena = req.getParameter("cena");
        String nrseryjny = req.getParameter("nrseryjny");
        String image = req.getParameter("image");
        
        if(nazwa.trim().isEmpty()){
            req.setAttribute("errorNazwa", "Enter product name");
        }
        if(rodzaj.trim().isEmpty()){
            req.setAttribute("errorRodzaj", "Enter type of product ");
        }
        if(cena.trim().isEmpty()){
            req.setAttribute("errorCena", "Enter Price");
        }
        if(nrseryjny.trim().isEmpty()){
            req.setAttribute("errorNrSeryjny", "Enter serial number");
        }
          if(image.trim().isEmpty()){
            req.setAttribute("errorImage", "Enter img url");
        }
        

if(!cena.trim().isEmpty() && !nazwa.trim().isEmpty() && !rodzaj.trim().isEmpty() && !nrseryjny.trim().isEmpty() && !image.trim().isEmpty()) {
        ProductBean obj = new ProductBean();
        obj.setNazwa(nazwa);
        obj.setRodzaj(rodzaj);
        obj.setCena(Double.parseDouble(cena));
        obj.setNrSeryjny(nrseryjny);
        obj.setImage(image);
        

       
        
       
        
        int status = ProductDao.insertProduct(obj);
        
         
            if (status >0)
                req.setAttribute("addSucces","Add product successful");
            else 
                req.setAttribute("addFail","Add product failed");
        
        }
        req.getRequestDispatcher(PAGE).include(req, resp);
        
    }

    

  
}
