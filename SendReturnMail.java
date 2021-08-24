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
		bookBean.UpdateBorrowStatus2(isbn, Return);//	status���u�ԋp���F�҂��v�ɃA�b�v�f�[�g



		String title = "���Ђ̕ԋp�\��";//���[���̃^�C�g��

        String message = "���Ђ̕ԋp�\�����󂯎��܂����B"+"\r\n"//���[���̖{��(���Ђ�\���҂����Ƃ��đg�ݍ���)
        		+ "������͎������M�ɂȂ�܂��B"+"\r\n"
        		+"����----------------------------------------------------����"+"\r\n"
        		+ "�\���Җ�:"+name+"\r\n"
        		+ "���Дԍ�:"+isbn+"\r\n"
        		+ "���Ж�:" +Title+"\r\n"
        		+ "�ԋp�\���:"+Return+"\r\n"
        		+"����----------------------------------------------------����"+"\r\n"
        		+"\r\n"
        		+"http://localhost:8080/BookManagement/WaitingList.jsp"+" (�ԋp�̏��F�֐i��)";

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
                    return new PasswordAuthentication("syosekikanri.sakuracom@gmail.com", "hpg8jcwpr427");//���M��Google�A�J�E���g
                }
            });

            MimeMessage mimeMessage = new MimeMessage(session);

            InternetAddress toAddress =
                    new InternetAddress("rt-mikami@sakura-communication.co.jp","�����瑍����");//	�{�Ԃł͂����ɂ����瑍���������͂���@("�����瑍�����̃��[���A�h���X","�����瑍����")//

            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);

            InternetAddress fromAddress =
                    new InternetAddress("syosekikanri.sakuracom@gmail.com","�����珑�ЊǗ�");//	���M�ҏ��

            mimeMessage.setFrom(fromAddress);

            mimeMessage.setSubject(title, "ISO-2022-JP");

            mimeMessage.setText(message,"ISO-2022-JP");

            Transport.send(mimeMessage);

            out.println("<htm><body>");
            out.println("���ԋp�\�����e��S���҂֑��M���܂����B");
            out.println("<br>");
            out.println("<button onclick=\"location.href='BookHome.jsp'\">�{���p���Јꗗ</button>");
            out.println("<body></html>");
        }
        catch(Exception e){
            out.println("<html><body>");
            out.println("���S���҂ւ̑��M�Ɏ��s���܂���");
	        out.println("<br>");
            out.println("<button onclick=\"location.href='BookHome.jsp'\">�{���p���Јꗗ</button>");
            out.println("</body></html>");
        }
        out.close();
    }
}