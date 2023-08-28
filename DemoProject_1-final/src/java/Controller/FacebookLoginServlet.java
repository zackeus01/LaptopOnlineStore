
import Model.Account;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Version;
import com.restfb.types.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/facebook-login")
public class FacebookLoginServlet extends HttpServlet {

    private static final String APP_ID = "793594985493909";
    private static final String APP_SECRET = "bb37e020a3b5224c396d7077348187d7";
    private static final String REDIRECT_URI = "http://localhost:9999/DemoProject_1_bk/facebook-login";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null) {
            FacebookClient.AccessToken accessToken = getAccessToken(code);
            if (accessToken != null) {
                User user = getUserInfo(accessToken.getAccessToken());
                // Lưu thông tin người dùng vào session hoặc làm xử lý khác
                String fnamee = null;
                String lnamee = user.getName();
                String emaill = user.getEmail();
                String per = "1";
                String username = user.getId();
                String password = user.getId();
                Account ac = new Account();

                Account a = ac.checkAccount(username, password);
                if (a != null) {
                    
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(1000);
                        session.setAttribute("acc", a);
                        response.sendRedirect("home");
                    
                } else {
                    ac.add(fnamee, lnamee, emaill, per, username, password);
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(1000);
                    session.setAttribute("acc", a);
                    response.sendRedirect("home");
                }
//                request.getSession().setAttribute("user", user);
//                response.sendRedirect("profile.jsp"); // Chuyển hướng đến trang profile
//                return;
            }
        }
    }

    private FacebookClient.AccessToken getAccessToken(String code) {
        try {
            return new DefaultFacebookClient(Version.LATEST)
                    .obtainUserAccessToken(APP_ID, APP_SECRET, REDIRECT_URI, code);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private User getUserInfo(String accessToken) {
        try {
            FacebookClient client = new DefaultFacebookClient(accessToken, Version.LATEST);
            return client.fetchObject("me", User.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
