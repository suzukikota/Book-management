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

	//	(閲覧用)検索無し　書籍一覧の表示
	public List<BookBean> BookBeanDBtoList(int offset){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
					+ "where delete_date != '削除' order by status, genre desc, yomi limit 10 offset ?";
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, offset);
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

	//	(閲覧用)検索あり　検索にヒットする書籍一覧表示用
	//	引数にkeyword
	public List<BookBean> BookBeanDBtoList2(String keyword,String Genre,int offset){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
					+ "where title like ? and genre like ? and delete_date != '削除'  "
					+ "order by status, genre desc, yomi limit 10 offset ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ps.setString(2,("%" + Genre + "%"));
			ps.setInt(3, offset);

			if(Genre.equals("すべてのジャンル") && keyword!=null) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where delete_date != '削除'  order by status, genre desc, yomi limit 10 offset ?";
				ps = con.prepareStatement(sql.toString());
				ps.setInt(1, offset);
			}

			if(Genre.equals("すべてのジャンル")) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where title like ? and delete_date != '削除'  order by status, genre desc, yomi limit 10 offset ?";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1,("%" + keyword + "%"));
				ps.setInt(2, offset);
			}

			if(keyword==null) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where delete_date != '削除' and genre = ? "
						+ "order by status, genre desc, yomi limit 10 offset ?";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, Genre);
				ps.setInt(2, offset);
			}

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

	//		(管理用)書籍一覧の表示用
	@SuppressWarnings("resource")
	public List<BookBean> BookBeanDBtoList3(String btn, String selectId, String selectIsbn, String selectTitle,String selectGenre, String selectPublisher, String selectStatus, String selectRental, String selectBorrow_date, String selectYomi,String change,int offset){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where delete_date != '削除' order by status desc, genre desc, cast(yomi as char) limit 30 offset ?";
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, offset);

			if(btn.equals("delete")) {
				sql = "update borrow set delete_date = '削除',borrow_date = '' where isbn = ? ";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("delete")) {
				sql = "update book set rental = '削除' where isbn = ? ";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("追加")) {
				sql ="insert into book (isbn,title,yomi,genre,publisher,rental) values (?, ?, ?, ?, ?, ?)"; // 追加
				ps= con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectTitle);
				ps.setString(3, selectYomi);
				ps.setString(4, selectGenre);
				ps.setString(5, selectPublisher);
				ps.setString(6, selectRental);
				ps.executeUpdate();
			}

			if(btn.equals("追加")) {
				sql ="insert into borrow (isbn,status,borrow_date,delete_date) values (?, ?, ?,?)"; // 追加
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectStatus);
				ps.setString(3, selectBorrow_date);
				ps.setString(4, "");
				ps.executeUpdate();
			}
			//OkRental.jspで追加
			if(btn.equals("追 加")) {
				sql ="insert into book (isbn,title,yomi,genre,publisher,rental) values (?, ?, ?, ?, ?,'')"; // 追加
				ps= con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectTitle);
				ps.setString(3, selectYomi);
				ps.setString(4, selectGenre);
				ps.setString(5, selectPublisher);
				ps.executeUpdate();
			}

			if(btn.equals("追 加")) {
				sql ="insert into borrow (isbn,status,borrow_date,delete_date) values (?, ?,'','')"; // 追加
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, selectIsbn);
				ps.setString(2, selectStatus);
				ps.executeUpdate();
			}
			if(btn.equals("更新")) {
				sql = "update borrow set status = ? where isbn = ? "; //変更
				ps =con.prepareStatement(sql.toString());
				ps.setString(1, change);
				ps.setString(2, selectIsbn);
				ps.executeUpdate();
			}

			if(btn.equals("更新")) {
				sql = "update borrow set borrow_date = '' where status = 'レンタル可'"; //変更
				ps =con.prepareStatement(sql.toString());
				ps.executeUpdate();
			}

			if(btn.equals("更新")) {
				sql = "update book a,borrow b set a.rental = b.borrow_date where a.isbn = b.isbn and b.status = 'レンタル可';"; //変更
				ps =con.prepareStatement(sql.toString());
				ps.executeUpdate();
			}



			sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where delete_date != '削除' order by status desc, genre desc, cast(yomi as char) limit 30 offset ?";
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, offset);
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

	//	(管理用)検索あり　検索にヒットする書籍一覧表示用
	//	引数にkeyword
	public List<BookBean> BookBeanDBtoList4(String keyword){
		List<BookBean> list4 = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date from borrow left join book on borrow.isbn = book.isbn where rental like ? and delete_date != '削除' order by status desc, genre desc, cast(yomi as char)";
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

//	レンタル申請画面へ遷移した際の、書籍番号と書籍名を取得するメソッド
	public List<BookBean> Rental(String isbn){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select isbn,title,rental from book where isbn = ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,isbn);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String Isbn = rs.getString("isbn");
				String title = rs.getString("title");
				String rental = rs.getString("rental");
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

	//	レンタル申請と同時にrentalカラムに「申請者名」をアップデートする
	public void UpdateBookRental(String name,String isbn) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");
			String sql = "update book set rental = ? where isbn = ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1, name);
			ps.setString(2, isbn);
			ps.executeUpdate();

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
	}

	//	レンタル申請と同時にstatusカラムに「レンタル承認待ち」、borrow_dateカラムに「レンタル日」をアップデートする
	public void UpdateBorrowStatus(String isbn,String rental) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");
			String sql = "update borrow set status = 'レンタル承認待ち' , borrow_date = ? where isbn = ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1, rental);
			ps.setString(2, isbn);
			ps.executeUpdate();

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
	}

	//	返却申請と同時にstatusカラムを「返却承認待ち」、borrow_dateカラムに「返却日」をアップデートする
	public void UpdateBorrowStatus2(String isbn,String Return) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");
			String sql ="update borrow set status = '返却承認待ち' , borrow_date = ? where isbn = ?";
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, Return);
			ps.setString(2, isbn);
			ps.executeUpdate();

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
	}

	//	承認待ちリストの表示
	public List<BookBean> Wating(int offset){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date "
					+ "from borrow join book on borrow.isbn = book.isbn "
					+ "where status like '%待ち' order by status, genre desc, yomi limit 10 offset ?";
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, offset);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
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

	public List<BookBean> Wating2(){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status,book.rental,borrow.borrow_date "
					+ "from borrow join book on borrow.isbn = book.isbn "
					+ "where status like '%待ち' order by status, genre desc, yomi";
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

	//	(レンタル)管理者による承認待ちリストにおける「承認」又は「拒否」に応じたDB操作
	public void UpdateRentalWating(String btn,String isbn) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="";
			ps = con.prepareStatement(sql.toString());

			if(btn.equals("approval")) {
				sql="update borrow set status = 'レンタル中'  where isbn = ?";
				ps=con.prepareStatement(sql.toString());
				ps.setString(1, isbn);
				ps.executeUpdate();

			}

			if(btn.equals("rejection")) {
				sql="update borrow set status = 'レンタル可' , borrow_date='' where isbn = ?";
				ps=con.prepareStatement(sql.toString());
				ps.setString(1, isbn);
				ps.executeUpdate();
			}

			if(btn.equals("rejection")) {
				sql="update book set rental = '' where isbn = ?";
				ps=con.prepareStatement(sql.toString());
				ps.setString(1, isbn);
				ps.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps !=null) {ps.close();}
				if(con !=null) {con.close();}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

	}

	//	(返却)管理者による承認待ちリストにおける「承認」又は「拒否」に応じたDB操作
	public void UpdateReturnWating(String btn,String isbn,String test) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="";
			ps = con.prepareStatement(sql.toString());

			if(btn.equals("approval")) {
				sql="update borrow set status = 'レンタル中'  where isbn = ?";
				ps=con.prepareStatement(sql.toString());
				ps.setString(1, isbn);
				ps.executeUpdate();

			}

			if(btn.equals("rejection")) {
				sql="update borrow set status = 'レンタル中' , borrow_date = ? where isbn = ?";
				ps=con.prepareStatement(sql.toString());
				ps.setString(1, test);
				ps.setString(2, isbn);
				ps.executeUpdate();
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps !=null) {ps.close();}
				if(con !=null) {con.close();}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

	}
	public List<BookBean> BookBeanDBtoList5(String keyword,String Genre){
		List<BookBean> list = new ArrayList<BookBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
					+ "where title like ? and genre like ? and delete_date != '削除'  "
					+ "order by status, genre desc, yomi";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,("%" + keyword + "%"));
			ps.setString(2,("%" + Genre + "%"));


			if(Genre.equals("すべてのジャンル") && keyword!=null) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where delete_date != '削除'  order by status, genre desc, yomi";
				ps = con.prepareStatement(sql.toString());

			}

			if(Genre.equals("すべてのジャンル")) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where title like ? and delete_date != '削除'  order by status, genre desc, yomi";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1,("%" + keyword + "%"));

			}

			if(keyword==null) {
				sql="select book.isbn,book.title,book.genre,book.publisher,borrow.status from borrow join book on borrow.isbn = book.isbn "
						+ "where delete_date != '削除' and genre = ? "
						+ "order by status, genre desc, yomi";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, Genre);

			}

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
}