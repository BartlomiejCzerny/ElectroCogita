package system.logowania;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import system.logowania.LoginBean;
import system.logowania.LoginDao;
import system.logowania.LogoutServlet;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
private static final String PAGE = "sign_in.jsp";




    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       resp.sendRedirect(PAGE);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String haslo = req.getParameter("haslo");
       
        boolean error = false;
        resp.setContentType("text/html");
    
        if(email.trim().isEmpty()){
            req.setAttribute("errMessageEmail", "Enter email");
        }
        
        if(haslo.trim().isEmpty()){
            req.setAttribute("errMessageHaslo", "Enter password");
        }
        
        LoginBean loginBean = new LoginBean();
        
        loginBean.setEmail(email);
        loginBean.setHaslo(haslo);

        LoginDao loginDao = new LoginDao();

        try {
            String userValidate = loginDao.authenticateUser(loginBean);

            if (userValidate.equals("Admin_Role")) {
                HttpSession session = req.getSession(); //Creating a session
                session.setAttribute("Admin", email); //setting session attribute
                req.setAttribute("userName", email);
                session.setAttribute("getEmail", email);

                req.getRequestDispatcher("index.jsp").forward(req, resp);
            } else if (userValidate.equals("Pracownik_Role")) {
                

                HttpSession session = req.getSession();
                session.setAttribute("Pracownik", email);
                session.setAttribute("getEmail", email);
                req.setAttribute("userName", email);

                req.getRequestDispatcher("index.jsp").forward(req, resp);
            } else if (userValidate.equals("User_Role")) {
                

                HttpSession session = req.getSession();
                session.setMaxInactiveInterval(10 * 60);
                session.setAttribute("User", email);
                session.setAttribute("getEmail", email);
                req.setAttribute("userName", email);

                req.getRequestDispatcher("index.jsp").forward(req, resp);
            } else {
                req.setAttribute("errMessageLogowanie", userValidate);
                

                
            }
        } catch (IOException e1) {
            e1.printStackTrace();
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        
        
      
     req.getRequestDispatcher(PAGE).include(req, resp);
        
    }

    

}
