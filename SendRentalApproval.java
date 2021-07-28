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

		String title = "���Ђ̃����^���\���̏��F";//���[���̃^�C�g��

        String message = "���Ђ̃����^���\���̏��F"+"\r\n"//���[���̖{��(���Ђ�\���҂����Ƃ��đg�ݍ���)
        				+ "������͎������M�ɂȂ�܂��B"+"\r\n"
        				+ "�\���Җ�:"+name+"����"+"\r\n"
        				+ "�����^���̐\��������܂����B"+"\r\n"
        				+ "���̋A�Г��ɂ��󂯎�艺�����B";



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
                    new InternetAddress("syosekikanri.sakuracom@gmail.com", name+"����");

            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);

            InternetAddress fromAddress =
                    new InternetAddress("syosekikanri.sakuracom@gmail.com","�����珑�ЊǗ�");

            mimeMessage.setFrom(fromAddress);

            mimeMessage.setSubject(title, "ISO-2022-JP");

            mimeMessage.setText(message,"ISO-2022-JP");

            Transport.send(mimeMessage);

            out.println("<htm><body>");
            out.println("�������^���\���̏��F��\���҂֑��M���܂����B");
            out.println("<body></html>");
        }
        catch(Exception e){
            out.println("<html><body>");
            out.println("�������^���\���̏��F��\���҂ւ̑��M�Ɏ��s���܂���");
            out.println("<br>�G���[�̓��e" + e);
            out.println("</body></html>");
        }

        out.close();
    }

}