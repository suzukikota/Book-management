package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import bean.BookBean;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendReturnMail")
public class SendReturnMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SendReturnMail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session2 = request.getSession();
		request.setCharacterEncoding("UTF-8");
		String Return=request.getParameter("return");
		String isbn=(String) session2.getAttribute("isbn");
		String Title=(String) session2.getAttribute("Title");
		String name=(String) session2.getAttribute("employee");

		BookBean bookBean=new BookBean();
		bookBean.UpdateBorrowStatus2(isbn, Return);//	statusを「返却承認待ち」にアップデート



		String title = "書籍の返却申請";//メールのタイトル

        String message = "書籍の返却申請を受け取りました。"+"\r\n"//メールの本文(書籍や申請者を情報として組み込む)
        		+ "こちらは自動送信になります。"+"\r\n"
        		+"○●----------------------------------------------------●○"+"\r\n"
        		+ "申請者名:"+name+"\r\n"
        		+ "書籍番号:"+isbn+"\r\n"
        		+ "書籍名:" +Title+"\r\n"
        		+ "返却予定日:"+Return+"\r\n"
        		+"○●----------------------------------------------------●○"+"\r\n"
        		+"\r\n"
        		+"http://localhost:8080/BookManagement/WaitingList.jsp"+" (返却の承認へ進む)";

        response.setContentType("text/html; charset=UTF-8");

        PrintWriter out = response.getWriter();
        try{
            Properties property = new Properties();

            property.put("mail.smtp.host","smtp.gmail.com");

            property.put("mail.smtp.auth", "true");
            property.put("mail.smtp.starttls.enable", "true");
            property.put("mail.smtp.host", "smtp.gmail.com");
            property.put("mail.smtp.port", "587");
            property.put("mail.smtp.debug", "true");

            Session session = Session.getInstance(property, new javax.mail.Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication("syosekikanri.sakuracom@gmail.com", "hpg8jcwpr427");//送信者Googleアカウント
                }
            });

            MimeMessage mimeMessage = new MimeMessage(session);

            InternetAddress toAddress =
                    new InternetAddress("rt-mikami@sakura-communication.co.jp","さくら総務宛");//	本番ではここにさくら総務宛先を入力する　("さくら総務宛のメールアドレス","さくら総務宛")//

            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);

            InternetAddress fromAddress =
                    new InternetAddress("syosekikanri.sakuracom@gmail.com","さくら書籍管理");//	送信者情報

            mimeMessage.setFrom(fromAddress);

            mimeMessage.setSubject(title, "ISO-2022-JP");

            mimeMessage.setText(message,"ISO-2022-JP");

            Transport.send(mimeMessage);

            out.println("<htm><body>");
            out.println("■返却申請内容を担当者へ送信しました。");
            out.println("<br>");
            out.println("<button onclick=\"location.href='BookHome.jsp'\">閲覧用書籍一覧</button>");
            out.println("<body></html>");
        }
        catch(Exception e){
            out.println("<html><body>");
            out.println("■担当者への送信に失敗しました");
	        out.println("<br>");
            out.println("<button onclick=\"location.href='BookHome.jsp'\">閲覧用書籍一覧</button>");
            out.println("</body></html>");
        }
        out.close();
    }
}