package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.mariadb.jdbc.Driver;

public class ManagerBean {
	private static final List<ManagerBean> answer = null;
	private String  id;
	private String  password;

	public ManagerBean() {}
	public ManagerBean(String id, String password) {
		this.id = id;
		this.password = password;
	}

	public String getId() { return id; }// getterという。フィールドの値を返すだけだが、JSPから頻繁に利用される。
	public String getPassword() { return password; }

	public List<ManagerBean> DBtoList(String selectId,String selectPassword){
		List<ManagerBean> list = new ArrayList<ManagerBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");


			String answer = "";

			String sql ="select * from ManagerBean where id = ? and password = ? ";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,selectId);
			ps.setString(1,selectPassword);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){ // 該当するデータが存在する場合は真（Yes）となる
				answer = "OK";
			}else{ // 該当するデータが存在しない場合は偽（No）となる
				answer = "NG";
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
		return answer;
	}

}
