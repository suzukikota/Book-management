package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

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

@WebServlet("/SendRentalApproval")
public class SendRentalApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SendRentalApproval() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String name=request.getParameter("employee");


		System.out.println(name);

		String title = "書籍のレンタル申請の承認";//メールのタイトル

        String message = "書籍のレンタル申請の承認"+"\r\n"//メールの本文(書籍や申請者を情報として組み込む)
        				+ "こちらは自動送信になります。"+"\r\n"
        				+ "申請者名:"+name+"さん"+"\r\n"
        				+ "レンタルの申請を承りました。"+"\r\n"
        				+ "次の帰社日にお受け取り下さい。";



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
                    return new PasswordAuthentication("syosekikanri.sakuracom@gmail.com", "hpg8jcwpr427");
                }
            });

            MimeMessage mimeMessage = new MimeMessage(session);

            InternetAddress toAddress =
                    new InternetAddress("syosekikanri.sakuracom@gmail.com", name+"さん");

            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);

            InternetAddress fromAddress =
                    new InternetAddress("syosekikanri.sakuracom@gmail.com","さくら書籍管理");

            mimeMessage.setFrom(fromAddress);

            mimeMessage.setSubject(title, "ISO-2022-JP");

            mimeMessage.setText(message,"ISO-2022-JP");

            Transport.send(mimeMessage);

            out.println("<htm><body>");
            out.println("■レンタル申請の承認を申請者へ送信しました。");
            out.println("<body></html>");
        }
        catch(Exception e){
            out.println("<html><body>");
            out.println("■レンタル申請の承認を申請者への送信に失敗しました");
            out.println("<br>エラーの内容" + e);
            out.println("</body></html>");
        }

        out.close();
    }

}