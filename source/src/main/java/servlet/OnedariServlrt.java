package servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.OnedariDao;
import dto.Onedari;

@WebServlet("/OnedariServlet")
@MultipartConfig 
public class OnedariServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    