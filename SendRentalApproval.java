package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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

import bean.BookBean;
import bean.Employee_InfoBean;

@WebServlet("/SendRentalApproval")
public class SendRentalApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SendRentalApproval() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String isbn = request.getParameter("isbn");
		String btn = request.getParameter("btn");

		//	�u���F�v���I�����ꂽ�ꍇ
		if(btn.equals("approval")) {

		BookBean bookBean=new BookBean();
		bookBean.UpdateRentalWating(btn, isbn);

		List<BookBean> list=bookBean.Rental(isbn);
		for(int i=0;i<list.size();i++) {
			bookBean=list.get(i);
		}

		String selectName=bookBean.getRental();
		Employee_InfoBean employee_InfoBean=new Employee_InfoBean();

		List<Employee_InfoBean> list2=employee_InfoBean.Employee_InfoDBtoList3(selectName);
		for(int i=0;i<list.size();i++) {
			employee_InfoBean=list2.get(i);
		}

		String mail=employee_InfoBean.getMail();
		String title = "���Ђ̃����^���\���̏��F";

        String message = "���Ђ̃����^���\���̏��F"+"\r\n"
        				+ "������͎������M�ɂȂ�܂��B"+"\r\n"
        				+ "�\���Җ�:"+selectName +"����"+"\r\n"
        				+ "�����^���̐\��������܂����B"+"\r\n"
        				+ "���̋A�Г��ɂ��󂯎�艺�����B"+"\r\n"
        				+ "��낵�����肢�������܂�";



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
                    new InternetAddress(mail,selectName+"����");// employee_info�e�[�u����mail�J�����Ɋi�[���ꂽ���[���A�h���X�̒�����A�\���҂ɊY�����郁�[���A�h���X���ɑ���

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

     // �u���ہv���I�����ꂽ�ꍇ

    }else if(btn.equals("rejection")) {
    		BookBean bookBean=new BookBean();

    		List<BookBean> list=bookBean.Rental(isbn);
    		for(int i=0;i<list.size();i++) {
    			bookBean=list.get(i);
    		}

    		String selectName=bookBean.getRental();
    		Employee_InfoBean employee_InfoBean=new Employee_InfoBean();

    		List<Employee_InfoBean> list2=employee_InfoBean.Employee_InfoDBtoList3(selectName);
    		for(int i=0;i<list.size();i++) {
    			employee_InfoBean=list2.get(i);
    		}
    		String mail=employee_InfoBean.getMail();
    		String title = "���Ђ̃����^���\���̔۔F";

            String message = "���Ђ̃����^���\���̔۔F"+"\r\n"
            				+ "������͎������M�ɂȂ�܂��B"+"\r\n"
            				+ "�\���Җ�:"+selectName +"����"+"\r\n"
            				+ "�����^���̐\�������邱�Ƃ��o���܂���ł����B"+"\r\n"
            				+ "��낵�����肢�������܂��B";



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
                        new InternetAddress(mail,selectName+"����");// employee_info�e�[�u����mail�J�����Ɋi�[���ꂽ���[���A�h���X�̒�����A�\���҂ɊY�����郁�[���A�h���X���ɑ���

                mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);

                InternetAddress fromAddress =
                        new InternetAddress("syosekikanri.sakuracom@gmail.com","�����珑�ЊǗ�");

                mimeMessage.setFrom(fromAddress);

                mimeMessage.setSubject(title, "ISO-2022-JP");

                mimeMessage.setText(message,"ISO-2022-JP");

                Transport.send(mimeMessage);
                bookBean.UpdateRentalWating(btn, isbn);
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
}