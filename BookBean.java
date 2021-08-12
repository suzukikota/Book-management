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
	private String rental;
	private String borrow_date;
	private String delete_date;
	private String yomi;

	public BookBean() {}
	public BookBean(String isbn,String title,String genre,String publisher,String status,String rental,String borrow_date,String delete_date,String yomi) {
		this.isbn=isbn;
		this.title=title;
		this.genre=genre;
		this.publisher=publisher;
		this.status=status;
		this.rental=rental;
		this.borrow_date=borrow_date;
		this.delete_date=delete_date;
		this.yomi=yomi;
	}
	public String getIsbn() {return isbn;}
	public String getTitle() {return title;}
	public String getGenre() {return genre;}
	public String getPublisher() {return publisher;}
	public String getStatus() {return status;}
	public String getRental() {return rental;}
	public String getBorrow_date() {return borrow_date;}
	public String delete_date() {return delete_date;}
	public String yomi() {return yomi;}

	//	�����Ȃ��@(�{���p)���Јꗗ�̕\���p
	public List<BookBean> BookBeanDBtoList(){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn where delete_date != '�폜' order by status desc , genre desc, title ";
			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");

				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date,delete_date,yomi));
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

	//	��������@�����Ƀq�b�g���鏑�Јꗗ�\���p
	//	������keyword
	public List<BookBean> BookBeanDBtoList2(String keyword){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn where title like ? and delete_date != '�폜' order by status desc , genre desc, title ";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");

				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date,delete_date,yomi));
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

	//		(�Ǘ��p)���Јꗗ�̕\���p
	@SuppressWarnings("resource")
	public List<BookBean> BookBeanDBtoList3(String btn, String selectId, String selectIsbn, String selectTitle,String selectGenre, String selectPublisher, String selectStatus, String selectRental, String selectBorrow_date, String selectYomi){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where delete_date != '�폜' order by status desc, genre desc, cast(yomi as char)";
			ps = con.prepareStatement(sql.toString());

			if(btn.equals("delete")) {
				sql = "update borrow set delete_date = '�폜' where isbn = ?";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("delete")) {
				sql = "update book set rental = '�폜' where isbn = ?";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("�ǉ�")) {
				sql ="insert into book (isbn,title,yomi,genre,publisher,rental) values (?, ?, ?, ?, ?, ?)"; // �ǉ�
				ps= con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectTitle);
				ps.setString(3, selectYomi);
				ps.setString(4, selectGenre);
				ps.setString(5, selectPublisher);
				ps.setString(6, selectRental);
				ps.executeUpdate();
			}

			if(btn.equals("�ǉ�")) {
				sql ="insert into borrow (isbn,status,borrow_date,delete_date) values (?, ?, ?, ?)"; // �ǉ�
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectStatus);
				ps.setString(3, selectBorrow_date);
				ps.setString(4, "");
				ps.executeUpdate();
			}

			sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where delete_date != '�폜' order by status desc, genre desc, cast(yomi as char)";
			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");
				String rental = rs.getString("rental");
				String borrow_date = rs.getString("borrow_date");

				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date,delete_date,yomi));
			}
		}catch (Exception e) {
			e.printStackTrace();

		}finally {
			try {
				if (ps != null) { ps.close();}
				if (con != null) { con.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	//	��������@�����Ƀq�b�g���鏑�Јꗗ�\���p
	//	������keyword
	public List<BookBean> BookBeanDBtoList4(String keyword){
		List<BookBean> list4 = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where rental like ? and delete_date != '�폜' order by status desc, genre desc, cast(yomi as char)";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");
				String rental = rs.getString("rental");
				String borrow_date = rs.getString("borrow_date");

				list4.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date,delete_date,yomi));
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
		return list4;
	}


	//	�����^���\����ʂ֑J�ڂ����ۂ́A���Дԍ��Ə��Ж����擾���郁�\�b�h
	public List<BookBean> Rental(String isbn){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select isbn,title from book where isbn = ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,isbn);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String Isbn = rs.getString("isbn");
				String title = rs.getString("title");
				list.add(new BookBean(Isbn,title,genre,publisher,status,rental,borrow_date,delete_date,yomi));
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