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
	public BookBean() {}
	public BookBean(String isbn,String title,String genre,String publisher,String status,String rental,String borrow_date) {
		this.isbn=isbn;
		this.title=title;
		this.genre=genre;
		this.publisher=publisher;
		this.status=status;
		this.rental=rental;
		this.borrow_date=borrow_date;
	}
	public String getIsbn() {return isbn;}
	public String getTitle() {return title;}
	public String getGenre() {return genre;}
	public String getPublisher() {return publisher;}
	public String getStatus() {return status;}
	public String getRental() {return rental;}
	public String getBorrow_date() {return borrow_date;}
	//	検索なし　(閲覧用)書籍一覧の表示用
	public List<BookBean> BookBeanDBtoList(){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");


			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn";

			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");
				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date));
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

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn where title like ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String genre = rs.getString("genre");
				String publisher = rs.getString("publisher");
				String status = rs.getString("status");
				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date));
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
	@SuppressWarnings("resource")
	public List<BookBean> BookBeanDBtoList3(String btn, String selectId, String selectIsbn, String selectTitle,String selectGenre, String selectPublisher, String selectStatus, String selectRental, String selectBorrow_date){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join employee_info on borrow.employee_id = employee_info.employee_id left join book on borrow.isbn = book.isbn order by status desc, genre desc, cast(title as char)";
			ps = con.prepareStatement(sql.toString());


			if(btn.equals("delete")) {
				sql = "delete from book where isbn = ? ";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}


			if(btn.equals("delete")) {
				sql = "delete from borrow where isbn = ? ";
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}



			if(btn.equals("追加")) {
				sql ="insert into book (isbn,title,genre,publisher,rental) values (?, ?, ?, ?, ?)"; // 追加
				ps= con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectTitle);
				ps.setString(3, selectGenre);
				ps.setString(4, selectPublisher);
				ps.setString(5, selectRental);
				ps.executeUpdate();
			}

			if(btn.equals("追加")) {
				sql ="insert into borrow (isbn,status,borrow_date) values (?, ?, ?)"; // 追加
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectStatus);
				ps.setString(3, selectBorrow_date);
				ps.executeUpdate();
			}

			sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join employee_info on borrow.employee_id = employee_info.employee_id left join book on borrow.isbn = book.isbn order by status desc, genre desc, cast(title as char)";
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

				list.add(new BookBean(isbn,title,genre,publisher,status,rental,borrow_date));
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