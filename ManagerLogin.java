package servlet;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ManagerLogin
 */
@WebServlet("/ManagerLogin")
public class ManagerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public ManagerLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		getServletContext().getRequestDispatcher("/Login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String pass = "200308";
		String result = null;

		try {
			MessageDigest hash = MessageDigest.getInstance("SHA-256");
			hash.reset();
			hash.update(pass.getBytes("utf8"));
			result = String.format("%064x", new BigInteger(1, hash.digest()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		String[] array = {"200308"};// OKとなるパスワード
		String match = "";
		String pw = request.getParameter("password");
		for(int i = 0; i < array.length; i++){
			if(pw.equals(array[i])) {
				match = "OK";
				break; // 一致するパスワードを見つけたので、for文を終了させ、無駄な比較をしないようにする。
			}
		}
		if(match.equals("OK")) {
			getServletContext().getRequestDispatcher("/OkLogin.jsp").forward(request, response); // ログイン成功の処理
		}else {
			getServletContext().getRequestDispatcher("/NgLogin.jsp").forward(request, response); // ログイン失敗の処理
		}
	}
}

