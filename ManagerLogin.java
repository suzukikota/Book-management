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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//		JavaBeansクラス名　変数 = new クラス名();
		//	System.out.println("id = " + request.getParameter("id"));
		String password = request.getParameter("password");

		String result = null;

		try {
			MessageDigest hash = MessageDigest.getInstance("SHA-256");
			hash.reset();
			hash.update(password.getBytes("utf8"));
			result = String.format("%064x", new BigInteger(1, hash.digest()));
			//	System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// JavaBeansメソッドの実行と、結果の受け取り
		String[] array = {"200308","abcde"};// OKとなるパスワード
		String match = "";
		String pw = request.getParameter("password");
		for(int i=0; i<array.length; i++){
			if(pw.equals(array[i])) {
				match = "OK";
				break; // 一致するパスワードを見つけたので、for文を終了させ、無駄な比較をしないようにする。
			}
		}
		if(match.equals("OK")) {
			getServletContext().getRequestDispatcher("/oklogin.jsp").forward(request, response); // ログイン成功の処理
		}else {
			getServletContext().getRequestDispatcher("/nglogin.jsp").forward(request, response); // ログイン失敗の処理
		}
	}
}

