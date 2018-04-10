package system.rejestracji;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
private static final String PAGE = "register.jsp";
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       resp.sendRedirect(PAGE);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        String imie = req.getParameter("imie");
        String nazwisko = req.getParameter("nazwisko");
        String telefon = req.getParameter("telefon");
        String email = req.getParameter("email");
        String haslo = req.getParameter("haslo");
        
        if(imie.trim().isEmpty()){
            req.setAttribute("errorImie", "Enter name");
        }
        if(nazwisko.trim().isEmpty()){
            req.setAttribute("errorNazwisko", "Enter surnane");
        }
        if(telefon.trim().isEmpty()){
            req.setAttribute("errorTelefon", "Enter phone");
        }
        if(email.trim().isEmpty()){
            req.setAttribute("errorEmail", "Enter email");
        }
        if(haslo.trim().isEmpty()){
            req.setAttribute("errorHaslo", "Enter password");
        }
        
        RegisterBean obj = new RegisterBean();
        obj.setImie(imie);
        obj.setNazwisko(nazwisko);
        obj.setTelefon(telefon);
        obj.setEmail(email);
        obj.setHaslo(haslo);
        
        int status = RegisterDao.insertRegister(obj);
        
         
            if (status >0)
                req.setAttribute("registetrSucces","Registration successful");
            else 
                req.setAttribute("registerFail","Registration failed");
        
        
        req.getRequestDispatcher(PAGE).include(req, resp);
        
    }

  

}
