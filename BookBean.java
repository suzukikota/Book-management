package bean;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.mariadb.jdbc.Driver;

public class BookBean {
	private String isbn;
	private String title;
	private String genre;
	private String publisher;
	private String status;
	private String name;
	private String borrow_date;

	public BookBean() {}
	public BookBean(String isbn,String title,String genre,String publisher,String status,String name,String borrow_date) {
		this.isbn=isbn;
		this.title=title;
		this.genre=genre;
		this.publisher=publisher;
		this.status=status;
		this.name=name;
		this.borrow_date=borrow_date;
	}
	public String getIsbn() {return isbn;}
	public String getTitle() {return title;}
	public String getGenre() {return genre;}
	public String getPublisher() {return publisher;}
	public String getStatus() {return status;}
	public String getName() {return name;}
	public String getBorrow_date() {return borrow_date;}

	//	検索なし　(閲覧用)書籍一覧の表示用
	public List<BookBean> BookBeanDBtoList(){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn";

			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");

				list.add(new BookBean(isbn,title,genre,publisher,status,name,borrow_date));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) { ps.close();}
				if (con != null) { con.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	//	検索あり　検索にヒットする書籍一覧表示用
	//	引数にkeyword
	public List<BookBean> BookBeanDBtoList2(String keyword){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn where title like ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");

				list.add(new BookBean(isbn,title,genre,publisher,status,name,borrow_date));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) { ps.close();}
				if (con != null) { con.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	//		(管理用)書籍一覧の表示用
	public List<BookBean> BookBeanDBtoList3(){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.title,book.genre,book.publisher,borrow.status,employee_info.name,borrow.borrow_date from borrow join employee_info on borrow.employee_id = employee_info.employee_id join book on borrow.isbn = book.isbn;";

			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");

				list.add(new BookBean(isbn,title,genre,publisher,status,name,borrow_date));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) { ps.close();}
				if (con != null) { con.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

}
